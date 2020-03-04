//
//  MyStocksVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class MyStocksVC: UIViewController {
//MARK: Properties
    var stocks: [Stock] = []
    var timer = Timer()
    
//MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startStockTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
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
        self.title = "My Stocks"
        self.view.backgroundColor = SettingsService.blackColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = SettingsService.grayColor //button color
        navigationController?.setStatusBarColor(backgroundColor: kMAINCOLOR)
        setupTableView()
        populateTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.register(UINib(nibName: "StockCell", bundle: nil), forCellReuseIdentifier: "stockCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() //removes extra unpopulated cells
        tableView.backgroundColor = SettingsService.blackColor
        tableView.separatorStyle = .none //removes separator line
    }
    
    fileprivate func populateTableView() {
        if let user = getCurrentUser() {
            user.setNeedsToReloadStocks()
            let userStocks = user.getUserStocks()
            DispatchQueue.main.async {
                self.stocks = userStocks
                self.tableView.reloadData()
            }
        } else { //if no user...
            deleteCurrentUser()
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()!
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    fileprivate func startStockTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.fetchAllStocksData), userInfo: nil, repeats: true)
    }
    
//MARK: IBActions
    
//MARK: Helpers
    @objc func fetchAllStocksData() {
        fetchAllStocks(stocks: stocks) { (error, resultsStocks) in
            let sortedStocks = resultsStocks.sorted { $0.rank < $1.rank } //ascendingly sort stocks received by their ranking
            DispatchQueue.main.async {
                if let error = error {
                    Service.presentAlert(on: self, title: "Fetch All Stocks Error", message: error)
                    return
                }
                self.stocks = sortedStocks
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: Extensions
extension MyStocksVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stock = stocks[indexPath.row]
        self.performSegue(withIdentifier: kSEGUETOSTOCKDETAILSVC, sender: stock)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MyStocksVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StockCell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
        cell.selectionStyle = .none //remove the selection indicator
        let stock = stocks[indexPath.row]
        cell.stock = stock
        cell.populateViews(showRank: true)
        cell.priceLabel.textColor = stock.isPositive ? SettingsService.greenColor : SettingsService.redColor //make textColor green if stock is doing good since market opened
        //        cell.backgroundColor = UIColor(hexString: "#2b2b30")
        cell.backgroundColor = SettingsService.blackColor
        return cell
    }
}
