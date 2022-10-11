//
//  FlightsViewController.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 6.10.2022.
//

import UIKit

class FlightsViewController: UIViewController {
    
    private let flightsPageReuseIdentifier = "flightsPageIdentifier"
    
    @IBOutlet weak var tableViewFVC: UITableView!
    
    private let viewModel = FlightsPageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.didViewLoad()
        registerCells()
        tableViewFVC.delegate = self
        tableViewFVC.dataSource = self

    }
    func registerCells() {
        tableViewFVC.register(.init(nibName: "FlightsPageTableViewCell", bundle: nil), forCellReuseIdentifier: flightsPageReuseIdentifier)
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension FlightsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.getModel(at: indexPath.row)
        let cell = tableViewFVC.dequeueReusableCell(withIdentifier: flightsPageReuseIdentifier, for: indexPath) as! FlightsPageTableViewCell
        
        cell.flightLabel.text = cellModel.departure?.airport
        cell.timeLabel.text = cellModel.departure?.time 
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailvc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let cellModel = viewModel.getModel(at: indexPath.row)
        
        detailvc.detailControllerType = .flights
        
        detailvc.flights = cellModel
    
        detailvc.modalPresentationStyle = .fullScreen
        self.present(detailvc, animated: true, completion: nil)
    }
    
}

extension FlightsViewController: UITableViewDelegate {
  
}
