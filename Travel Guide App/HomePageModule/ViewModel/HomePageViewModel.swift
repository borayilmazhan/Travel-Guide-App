//
//  HomePageViewModel.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 29.09.2022.
//

import Foundation

protocol HomePageViewModelProtocol: AnyObject {
    func didCellItemFetch(isSuccess: Bool)
}

class HomePageViewModel {
    private let model = HomePageModel()
    
    weak var viewDelegate: HomePageViewModelProtocol?
    
    init() {
        model.delegate = self
    }
    func didViewLoad() {
        model.fetchData()
    }
    func numberOfItems() -> Int {
        return model.informations.count
    }
    func getModel(at index: Int) -> HomePageCellViewModel {
        let information = model.informations[index]
        
        return transformPostToPostListModel(from: information)
    }
    
    private func transformPostToPostListModel(from information: Information) -> HomePageCellViewModel {
        return HomePageCellViewModel(information.title, information.content, information.category, information.image,information.id)
    }
    
}

// MARK: - GalleryModel Delegate Methods
extension HomePageViewModel: HomePageModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            viewDelegate?.didCellItemFetch(isSuccess: true)
        } else {
            // TODO:
            print("didDataFetchProcessFinish, false geldi.")
        }
        
    }
}
