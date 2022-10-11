//
//  DetailViewController.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 9.10.2022.
//

import UIKit
import CoreData


class DetailViewController: UIViewController {
    
    var detailControllerType: DetailViewControllerEnum = .hotels
    
    var hotels: HotelsPageCellViewModel?
    var articles: HomePageCellViewModel?
    var flights: FlightsPageCellViewModel?
    
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var imageViewDVC: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        readData()
        

    }
    func configure() {
        
        switch detailControllerType {
        case .hotels:
            setAsHotel()
        case .articles:
            setAsArticle()
        case.flights:
            setAsFlight()
        default:
                setAsHotel()
        }
    
    }
    
    func setAsHotel() {
        titleLabel.text = hotels?.name
        writingLabel.text = hotels?.description
        imageViewDVC.image = UIImage(named: hotels?.image ?? "")
        categoriesLabel.text = "Hotels"
    }
    
    func setAsArticle() {
        titleLabel.text = articles?.title
        writingLabel.text = articles?.content
        imageViewDVC.image = UIImage(named: articles?.image ?? "")
        categoriesLabel.text = articles?.category
    }
    func setAsFlight() {
        titleLabel.text = flights?.arrival?.airport
        writingLabel.text = flights?.departure?.time
        imageViewDVC.image = UIImage(named: "flights")
        categoriesLabel.text = "Flights"
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: Any) {
        switch self.detailControllerType {
        case .hotels:
            save(id: self.hotels?.id ?? "", type: DetailViewControllerEnum.hotels.rawValue)
        case .flights:
            save(id: self.flights?.flight?.number ?? "", type: DetailViewControllerEnum.flights.rawValue)
        case .articles:
            save(id: self.articles?.id ?? "", type: DetailViewControllerEnum.articles.rawValue)
        default:
            save(id: self.hotels?.id ?? "", type: DetailViewControllerEnum.hotels.rawValue)

        }
    
    }
    
  
    func save(id:String, type:String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newBookmark = NSEntityDescription.insertNewObject(forEntityName: "Bookmarks", into: context)
        
        //Attributes
        
        newBookmark.setValue(id, forKey: "id")
        newBookmark.setValue(type, forKey: "type")
                
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
    }
    
    func readData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookmarks")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    if let id = result.value(forKey: "id") as? String {
                         print(id)
                    }
                    if let type = result.value(forKey: "type") as? String {
                        print(type)
                    }
                   
                }
            }
        } catch {
            print("error")
            
        }
     
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)

    }
}



protocol Persistable {
    var id: String { get }
    var type: String { get }
}

enum DetailViewControllerEnum: String {
    case flights = "flights"
    case hotels = "hotels"
    case articles = "articles"
}
