//
//  HotelsPageViewModule.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 7.10.2022.
//

import Foundation

protocol HotelsPageViewModelProtocol: AnyObject {
    func didCellItemFetch(isSuccess: Bool)
}

class HotelsPageViewModel {
    private let model = HotelsPageModel()
    
    weak var viewDelegate: HotelsPageViewModelProtocol?
    
    init() {
        model.delegate = self
    }
    func didViewLoad() {
        model.fetchData()
    }
    func numberOfItems() -> Int {
        return model.hotels.count
    }
    func getModel(at index: Int) -> HotelsPageCellViewModel {
        let hotel = model.hotels[index]
        
        return transformPostToPostListModel(from: hotel)
    }
    
    private func transformPostToPostListModel(from hotel: Hotels) -> HotelsPageCellViewModel {
        return HotelsPageCellViewModel(hotel.name, hotel.description, hotel.image, hotel.score, hotel.website,hotel.id)
    }
    
}

// MARK: - GalleryModel Delegate Methods
extension HotelsPageViewModel: HotelsPageModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            viewDelegate?.didCellItemFetch(isSuccess: true)
        } else {
            // TODO:
            print("didDataFetchProcessFinish, false geldi.")
        }
        
    }
}
