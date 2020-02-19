//
//  TrendingVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class TrendingVC: UIViewController {
//MARK: Properties
    var stocks: [Stock] = []
    
//MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
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
    fileprivate func setupTabBar() {
        guard let tabBar = self.tabBarController?.tabBar else { return }
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 20
        tabBar.backgroundColor = .clear
        tabBar.backgroundImage = UIImage()
        tabBar.barTintColor = .clear //bar color
        tabBar.tintColor = kMAINCOLOR //selected tab
        tabBar.unselectedItemTintColor = SettingsService.blackColor
        //MARK: Tab Bar Size Customization
        let width = self.view.frame.width - 100
        var newFrame = tabBar.frame
//        newFrame.size.height = 100
//        newFrame.origin.y = view.frame.size.height - 100
        newFrame.size.width = width
        newFrame.origin.x = (view.frame.width - width) / 2 //centers it
        tabBar.frame = newFrame
    }
    
    fileprivate func setupViews() {
        self.title = "Trending"
        self.navigationController!.navigationBar.isTranslucent = false
        setupTableView()
        createTestStocks()
    }
    
    fileprivate func setupTableView() {
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
extension TrendingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stock = stocks[indexPath.row]
        self.performSegue(withIdentifier: kSEGUETOSTOCKDETAILSVC, sender: stock)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TrendingVC: UITableViewDataSource {
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
