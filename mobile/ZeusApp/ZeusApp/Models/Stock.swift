//
//  Stock.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

class Stock {
    var name: String
    var shortName: String
    var price: String
    var imageUrl: String
    var rank: Int
    var isFollowing: Bool
    
    init(_name: String, _shortName: String, _price: String, _imageUrl: String, _rank: Int = 0, _isFollowing: Bool = false) {
        self.name = _name
        self.shortName = _shortName
        self.price = _price
        self.imageUrl = _imageUrl
        self.rank = _rank
        self.isFollowing = _isFollowing
    }
}
