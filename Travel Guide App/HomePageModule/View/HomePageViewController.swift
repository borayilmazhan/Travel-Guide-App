//
//  ViewController.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 29.09.2022.
//

import UIKit

class HomePageViewController: UIViewController {

    private let homePageReuseIdentifier = "homePageCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flightsButton: UIButton!
    @IBOutlet weak var hotelsButton: UIButton!
    
    private let viewModel = HomePageViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.didViewLoad()
//        hotelsViewTapped()
//        flightsViewTapped()
        registerCells()
        getData()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let blurFlights = UIVisualEffectView(effect: UIBlurEffect(style:
                    UIBlurEffect.Style.light))
        blurFlights.frame = flightsButton.bounds
        blurFlights.isUserInteractionEnabled = false //This allows touches to forward to the button.
        flightsButton.insertSubview(blurFlights, at: 0)
        
        let blurHotels = UIVisualEffectView(effect: UIBlurEffect(style:
                    UIBlurEffect.Style.light))
        
        blurHotels.frame = hotelsButton.bounds
        blurHotels.isUserInteractionEnabled = false //This allows touches to forward to the button.
        hotelsButton.insertSubview(blurHotels, at: 0)
        
    }
    @IBAction func hotelsButtonAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let hotelsvc = storyBoard.instantiateViewController(withIdentifier: "HotelsViewController") as! HotelsViewController
        hotelsvc.modalPresentationStyle = .fullScreen
        self.present(hotelsvc, animated: true, completion: nil)
    }
    @IBAction func flightsButtonAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let flightsvc = storyBoard.instantiateViewController(withIdentifier: "FlightsViewController") as! FlightsViewController
        flightsvc.modalPresentationStyle = .fullScreen
        self.present(flightsvc, animated: true, completion: nil)

    }
    func registerCells() {
        collectionView.register(.init(nibName: "HomePageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: homePageReuseIdentifier)
    }
    
    func getData() {
        
    }

}



extension HomePageViewController: UICollectionViewDelegate {
    
}

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellModel = viewModel.getModel(at: indexPath.row)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homePageReuseIdentifier, for: indexPath) as! HomePageCollectionViewCell
        
        cell.titleLabel.text = cellModel.title
        cell.writingLabel.text = cellModel.content
        cell.imageView.image = UIImage(named: cellModel.image ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailvc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let cellModel = viewModel.getModel(at: indexPath.row)
        
        detailvc.detailControllerType = .articles
        detailvc.articles = cellModel
        
        detailvc.modalPresentationStyle = .fullScreen
        self.present(detailvc, animated: true, completion: nil)
    }
    
    
}
//// MARK: - PostListModel Delegate Methods
//extension HomePageViewController: HomePageViewModelProtocol {
//    func didCellItemFetch(isSuccess: Bool) {
//        if isSuccess {
//            DispatchQueue.main.async { [weak self] in
//                self?.collectionView.reloadData()
//            }
//        }
//    }
//
//}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: UIScreen.main.bounds.height * 0.35)
    }
}

