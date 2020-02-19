//
//  RecommendationVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class RecommendationVC: UIViewController {
//MARK: Properties
    var stocks: [Stock] = []
    
//MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case kSEGUETOSTOCKDETAILSVC:
            guard let stock = sender as? Stock else { return }
            let vc: StockDetailsVC = (segue.destination as? StockDetailsVC)!
            vc.stock = stock
        default:
            break
        }
    }
    
//MARK: Private Methods
    fileprivate func setupViews() {
        setupTableView()
        createTestStocks()
    }
    
    fileprivate func setupTableView() {
        self.title = "Suggestions"
        self.navigationController!.navigationBar.isTranslucent = false
        tableView.register(UINib(nibName: "StockCell", bundle: nil), forCellReuseIdentifier: "stockCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() //removes extra unpopulated cells
    }
    
    fileprivate func createTestStocks() {
        let stock1 = Stock(_name: "Bitcoin", _shortName: "BTC", _price: "8,900", _imageUrl: "", _rank: 1)
        let stock2 = Stock(_name: "Etherium", _shortName: "ETH", _price: "80", _imageUrl: "", _rank: 2)
        let stock3 = Stock(_name: "Tesla", _shortName: "TSL", _price: "600", _imageUrl: "", _rank: 3)
        let stock4 = Stock(_name: "Apple", _shortName: "APL", _price: "8,900", _imageUrl: "", _rank: 4)
        let stock5 = Stock(_name: "Bitcoin", _shortName: "BTC", _price: "8,900", _imageUrl: "", _rank: 5)
        let stock6 = Stock(_name: "Etherium", _shortName: "ETH", _price: "80", _imageUrl: "", _rank: 6)
        let stock7 = Stock(_name: "Tesla", _shortName: "TSL", _price: "600", _imageUrl: "", _rank: 7)
        let stock8 = Stock(_name: "Apple", _shortName: "APL", _price: "8,900", _imageUrl: "", _rank: 8)
        let stock9 = Stock(_name: "Bitcoin", _shortName: "BTC", _price: "8,900", _imageUrl: "", _rank: 9)
        let stock10 = Stock(_name: "Etherium", _shortName: "ETH", _price: "80", _imageUrl: "", _rank: 10)
        let stock11 = Stock(_name: "Tesla", _shortName: "TSL", _price: "600", _imageUrl: "", _rank: 11)
        let stock12 = Stock(_name: "Apple", _shortName: "APL", _price: "8,900", _imageUrl: "", _rank: 12)
        stocks.append(contentsOf: [stock1, stock2, stock3, stock4, stock5, stock6, stock7, stock8, stock9, stock10, stock11, stock12])
    }
    
//MARK: IBActions
    
//MARK: Helpers
    
}

//MARK: Extensions
extension RecommendationVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stock = stocks[indexPath.row]
        self.performSegue(withIdentifier: kSEGUETOSTOCKDETAILSVC, sender: stock)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension RecommendationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StockCell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
        cell.selectionStyle = .none //remove the selection indicator
        cell.stock = stocks[indexPath.row]
        cell.populateViews(showRank: true)
        return cell
    }
}

