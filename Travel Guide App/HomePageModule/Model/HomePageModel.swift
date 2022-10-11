//
//  HomePageModel.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 29.09.2022.
//

import Foundation

protocol HomePageModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

final class HomePageModel {
    
    weak var delegate: HomePageModelProtocol?
    
    var informations: [Information]  = []
    
    func fetchData() {
        let jsonData = readLocalJSONFile(forName: "articles")
        if let data = jsonData {
            if let sampleRecordObj = parse(jsonData: data) {
                //You can read sampleRecordObj just like below.
//                print("users list: \(sampleRecordObj.first?.id)")
                informations = sampleRecordObj
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
    
    func parse(jsonData: Data) -> [Information]? {
        do {
            let decodedData = try JSONDecoder().decode([Information].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
}
