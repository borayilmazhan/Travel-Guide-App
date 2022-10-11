//
//  HomePageModel.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 7.10.2022.
//

import Foundation

protocol HotelsPageModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

final class HotelsPageModel {
    
    weak var delegate: HotelsPageModelProtocol?
    
    var hotels: [Hotels]  = []
    
    func fetchData() {
        let jsonData = readLocalJSONFile(forName: "hotels")
        if let data = jsonData {
            if let sampleRecordObj = parse(jsonData: data) {
                //You can read sampleRecordObj just like below.
//                print("users list: \(sampleRecordObj.first?.id)")
                hotels = sampleRecordObj
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
    
    func parse(jsonData: Data) -> [Hotels]? {
        do {
            let decodedData = try JSONDecoder().decode([Hotels].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
}
