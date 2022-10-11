//
//  HomePageEntity.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 29.09.2022.
//

import Foundation

class HomePageCellViewModel {
    
    var title: String?
    var content: String?
    var category: String?
    var image: String?
    var id: String?
    
    init(_ title: String?, _ content: String?, _ category: String?, _ image: String?, _ id:String) {
        self.title = title
        self.content = content
        self.category = category
        self.image = image
        self.id = id

    }
    
}

struct Information: Codable {
    
    let id: String
    let title: String
    let content: String
    let category: String
    let image: String
}
