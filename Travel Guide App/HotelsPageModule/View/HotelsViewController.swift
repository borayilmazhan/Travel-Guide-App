//
//  HotelsViewController.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 7.10.2022.
//

import UIKit

class HotelsViewController: UIViewController {

    private let hotelsPageReuseIdentifier = "hotelsPageIdentifier"
    
    @IBOutlet weak var hotelsTableView: UITableView!
    
    private let viewModel = HotelsPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.didViewLoad()
        registerCells()
        hotelsTableView.delegate = self
        hotelsTableView.dataSource = self
    }
    func registerCells() {
        hotelsTableView.register(.init(nibName: "HotelsPageTableViewCell", bundle: nil), forCellReuseIdentifier: hotelsPageReuseIdentifier)
    }
    @IBAction func hotelsButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HotelsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.getModel(at: indexPath.row)
        let cell = hotelsTableView.dequeueReusableCell(withIdentifier: hotelsPageReuseIdentifier, for: indexPath) as! HotelsPageTableViewCell
        
        cell.hotelsNameLabel.text = cellModel.name
        cell.scoreLabel.text = cellModel.score
        cell.hotelsImageView.image = UIImage(named: cellModel.image ?? "")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailvc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let cellModel = viewModel.getModel(at: indexPath.row)
        
        detailvc.detailControllerType = .hotels
        
        detailvc.hotels = cellModel
    
        detailvc.modalPresentationStyle = .fullScreen
        self.present(detailvc, animated: true, completion: nil)
    }
    
    
}

extension HotelsViewController: UITableViewDelegate {
  
}
