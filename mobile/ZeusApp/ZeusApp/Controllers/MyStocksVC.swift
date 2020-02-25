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
    
//MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateStocks()
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
    fileprivate func populateStocks() {
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
    
    fileprivate func setupViews() {
        self.title = "My Stocks"
        self.navigationController!.navigationBar.isTranslucent = false

        setupTableView()
        populateStocks()
    }
    
    fileprivate func setupTableView() {
        tableView.register(UINib(nibName: "StockCell", bundle: nil), forCellReuseIdentifier: "stockCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() //removes extra unpopulated cells
    }
    
//MARK: IBActions
    
//MARK: Helpers
    
}

//MARK: Extensions
extension MyStocksVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
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
        cell.stock = stocks[indexPath.row]
        cell.populateViews(showRank: false)
        return cell
    }
}
