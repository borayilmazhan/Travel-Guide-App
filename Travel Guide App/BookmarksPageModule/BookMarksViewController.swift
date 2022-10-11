//
//  BookMarksViewController.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 10.10.2022.
//

import UIKit
import CoreData

class BookMarksViewController: UIViewController {
    
    @IBOutlet weak var tableViewBVC: UITableView!
    
    var typeArray = [String]()
    var idArray = [String]()
    var selected = String()
    var selectedId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewBVC.dataSource = self
        tableViewBVC.delegate = self
        
        getData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @objc func getData() {
        
        typeArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookmarks")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    if let id = result.value(forKey: "id") as? String {
                        self.idArray.append(id)
                    }
                    if let type = result.value(forKey: "type") as? String {
                        self.typeArray.append(type)
                    }
                    self.tableViewBVC.reloadData()
                }
            }
        } catch {
            print("error")
            
        }
        
        
    }
    
}

extension BookMarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = idArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailvc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        selected = typeArray[indexPath.row]
        selectedId = typeArray[indexPath.row]
        
        detailvc.modalPresentationStyle = .fullScreen
        self.present(detailvc, animated: true, completion: nil)

    }
    
}

extension BookMarksViewController: UITableViewDelegate {
    
}
