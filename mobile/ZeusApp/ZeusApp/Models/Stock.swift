//
//  Stock.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

class Stock: Codable {
    
    var name: String
    var shortName: String
    var price: String
    var imageUrl: String
    var rank: Int
    var isFollowing: Bool
    var trendingStocks: [Stock] = []
    var suggestedStocks: [Stock] = []
    var isPositive: Bool
    
    init(_name: String = "", _shortName: String = "", _price: String = "", _imageUrl: String = "", _rank: Int = 0, _isFollowing: Bool = false, _isPositive: Bool = true) {
        self.name = _name
        self.shortName = _shortName
        self.price = _price
        self.imageUrl = _imageUrl
        self.rank = _rank
        self.isFollowing = _isFollowing
        self.isPositive = _isPositive
    }
}

extension Stock: Equatable { //to be able to use .contains method
    static func == (lhs: Stock, rhs: Stock) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Stock: Hashable { //so I can make elemt of array of Stocks unique
    func hash(into hasher: inout Hasher) {
        hasher.combine(name.hashValue)
    }
}

func saveTrendingStocks(stocks: [Stock]) {
    guard let stocksData = try? JSONEncoder().encode(stocks) else { //decode array of stocks
        fatalError("could not encode list of stocks")
    }
    let userDefaults = UserDefaults.standard
    userDefaults.set(stocksData, forKey: kTRENDINGSTOCKS)
    userDefaults.synchronize()
}

func saveSuggestedStocks(stocks: [Stock]) {
    guard let stocksData = try? JSONEncoder().encode(stocks) else { //decode array of stocks
        fatalError("could not encode list of stocks")
    }
    let userDefaults = UserDefaults.standard
    userDefaults.set(stocksData, forKey: kSUGGESTEDSTOCKS)
    userDefaults.synchronize()
}

///Get array of unique stocks from trending and suggested
func loadAllStocks() -> [Stock] {
    var stocks: [Stock] = []
    if let trendingData = UserDefaults.standard.data(forKey: kTRENDINGSTOCKS),
        let trendingStocks = try? JSONDecoder().decode([Stock].self, from: trendingData) {
        stocks += trendingStocks
    }
    if let suggestedData = UserDefaults.standard.data(forKey: kSUGGESTEDSTOCKS),
        let suggestedStocks = try? JSONDecoder().decode([Stock].self, from: suggestedData) {
        stocks += suggestedStocks
    }
    print("All Trending and Suggested Stocks are: \(stocks)")
    return Array(Set(stocks)) //makes sure stocks are unique
}

///Fetches all data of stocks
func fetchAllStocks(stocks: [Stock], completion: @escaping(_ error: String?, _ stocks: [Stock]) -> Void) {
    guard let token = UserDefaults.standard.string(forKey: kTOKEN) else { print("No token"); return }
    var resultStocks: [Stock] = []
    for stock in stocks {
        fetchStockDetails(stock: stock, token: token) { (error, stock) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(error, resultStocks)
                }
                resultStocks.append(stock!)
                if resultStocks.count == stocks.count {
                    for stock in resultStocks {
                        print("Updated stock = \(stock)")
                    }
                    completion(nil, resultStocks)
                }
            }
        }
    }
}
