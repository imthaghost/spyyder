//
//  StockCodable.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/4/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

//struct CompanyProfile: Codable {
//    let price: Double
//    let beta, volAvg, mktCap, lastDiv: String
//    let range: String
//    let changes: Double
//    let changesPercentage, companyName, exchange, industry: String
//    let website: String
//    let profileDescription, ceo, sector: String
//    let image: String
//
//    enum CodingKeys: String, CodingKey {
//        case price, beta, volAvg, mktCap, lastDiv, range, changes, changesPercentage, companyName, exchange, industry, website
//        case profileDescription = "description"
//        case ceo, sector, image
//    }
//}

struct Profile: Codable {
    let price: Double
    let beta, volAvg, mktCap, lastDiv: String
    let range: String
    let changes: Double
    let changesPercentage, companyName, exchange, industry: String
    let website: String
    let profileDescription, ceo, sector: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case price, beta, volAvg, mktCap, lastDiv, range, changes, changesPercentage, companyName, exchange, industry, website
        case profileDescription = "description"
        case ceo, sector, image
    }
}
    
//struct StockCodable: Codable {
//    let ceo: String
//    let changes: Double
//    let changesPercentage: String
//    let companyName: String
//    let description: String
//    let exchange: String
//    let imageUrl: String
//    let industry: String
//    let totalVolume: String //totalVolume = mktCap
//    let price: Double
//    let range: String
//    let sector: String //sector or industry; e.g. Technology
//    let volAvg: String
//    let website: String
//
//    enum CodingKeys: String, CodingKey {
//        case ceo = "ceo"
//        case changes = "changes"
//        case changesPercentage = "changesPercentage"
//        case companyName = "companyName"
//        case description = "description"
//        case exchange = "exchange"
//        case imageUrl = "image"
//        case industry = "industry"
//        case totalVolume = "mktCap" //totalVolume = mktCap
//        case price = "price"
//        case range = "range"
//        case sector = "sector" //sector or industry; e.g. Technology
//        case volAvg = "volAvg"
//        case website = "website"
//    }
//}
    
//    var profile: [StockCodable]
    
//    var stockProfile: StockCodable
//    enum CodingKeys: String, CodingKey {
//        case stockProfile = "profile"
//    }
//}
