//
//  FlightsPageViewModel.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 7.10.2022.
//

import Foundation

protocol FlightsPageViewModelProtocol: AnyObject {
    func didCellItemFetch(isSuccess: Bool)
}

class FlightsPageViewModel {
     let model = FlightsPageModel()
    
    weak var viewDelegate: FlightsPageViewModelProtocol?
    
    init() {
        model.delegate = self
    }
    func didViewLoad() {
        model.fetchData()
    }
    func numberOfItems() -> Int {
        return model.flights.count
    }
    func numberOfFilteredItems() -> Int {
        return model.filteredFlights.count
    }
    func getModel(at index: Int) -> FlightsPageCellViewModel {
        let flight = model.flights[index]
        
        return transformPostToPostListModel(from: flight)
    }
    func getFilteredModel(at index: Int) -> FlightsPageCellViewModel {
        let flight = model.filteredFlights[index]
        
        return transformPostToPostListModel(from: flight)
    }
    
    private func transformPostToPostListModel(from flight: Flights) -> FlightsPageCellViewModel {
        return FlightsPageCellViewModel(flight.departure, flight.arrival, flight.airline, flight.flight)
    }
    
}

// MARK: - GalleryModel Delegate Methods
extension FlightsPageViewModel: FlightsPageModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            viewDelegate?.didCellItemFetch(isSuccess: true)
        } else {
            // TODO:
            print("didDataFetchProcessFinish, false geldi.")
        }
        
    }
}
