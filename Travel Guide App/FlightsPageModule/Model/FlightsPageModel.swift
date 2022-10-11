//
//  FlightsPageModel.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 7.10.2022.
//

import Foundation

protocol FlightsPageModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

final class FlightsPageModel {
    
    weak var delegate: FlightsPageModelProtocol?
    
    var flights: [Flights]  = []
    var filteredFlights: [Flights] = []
    
    func fetchData() {
        let jsonData = readLocalJSONFile(forName: "flights")
        if let data = jsonData {
            if let sampleRecordObj = parse(jsonData: data) {
                //You can read sampleRecordObj just like below.
//                print("users list: \(sampleRecordObj.first?.id)")
                flights = sampleRecordObj
                self.delegate?.didDataFetchProcessFinish(true)
            }
        }
    }
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func parse(jsonData: Data) -> [Flights]? {
        do {
            let decodedData = try JSONDecoder().decode([Flights].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
}
