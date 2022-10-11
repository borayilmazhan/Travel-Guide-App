//
//  SearchViewController.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 10.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let flightsPageReuseIdentifier = "flightsPageIdentifier"
    private let hotelsPageReuseIdentifier = "hotelsPageIdentifier"

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let flightsModel = FlightsPageViewModel()
    private let hotelsModel = HotelsPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchTableView.dataSource = self
        registerCells()
        flightsModel.didViewLoad()
        
    }
    func registerCells() {
        searchTableView.register(.init(nibName: "FlightsPageTableViewCell", bundle: nil), forCellReuseIdentifier: flightsPageReuseIdentifier)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightsModel.numberOfFilteredItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = flightsModel.getFilteredModel(at: indexPath.row)
        let cell = searchTableView.dequeueReusableCell(withIdentifier: flightsPageReuseIdentifier, for: indexPath) as! FlightsPageTableViewCell
        
        cell.flightLabel.text = cellModel.departure?.airport
        cell.timeLabel.text = cellModel.departure?.time
        return cell
    }
    
    
}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        flightsModel.model.filteredFlights.removeAll()
        for flight in flightsModel.model.flights {
            if (flight.airline?.name ?? "").contains(searchText) {
                flightsModel.model.filteredFlights.append(flight)
            }
        }
        searchTableView.reloadData()
    }
}
