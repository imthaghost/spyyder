//
//  StocksVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class StocksVC: UIViewController {
//MARK: Properties
    var stocks: [Stock] = []
    
//MARK: IBOutlets
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Private Methods
    fileprivate func setupViews() {
        createTestStocks()
    }
    
    fileprivate func createTestStocks() {
        let stock1 = Stock(_name: "Bitcoin", _shortName: "BTC", _price: "8,900", _imageUrl: "")
        let stock2 = Stock(_name: "Etherium", _shortName: "ETH", _price: "80", _imageUrl: "")
        let stock3 = Stock(_name: "Tesla", _shortName: "TSL", _price: "600", _imageUrl: "")
        let stock4 = Stock(_name: "Apple", _shortName: "APL", _price: "8,900", _imageUrl: "")
        stocks.append(contentsOf: [stock1, stock2, stock3, stock4])
    }
    
//MARK: IBActions
    
//MARK: Helpers
    
}

//MARK: Extensions



