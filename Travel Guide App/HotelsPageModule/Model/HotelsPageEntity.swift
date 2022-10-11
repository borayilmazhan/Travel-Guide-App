//
//  HotelsPageEntity.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 7.10.2022.
//

import Foundation

class HotelsPageCellViewModel {
    
    var name: String?
    var description: String?
    var image: String?
    var score: String?
    var website: String?
    var id: String?
    
    init(_ name: String?, _ description: String?, _ image: String?, _ score: String?, _ website: String?,_ id: String?) {
        self.name = name
        self.description = description
        self.image = image
        self.score = score
        self.website = website
        self.id = id
    }
    
}

struct Hotels: Codable {
    
    let id: String
    let name: String
    let description: String
    let image: String
    let score: String
    let website: String

}
