//
//  StockDetailsVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class StockDetailsVC: UIViewController {
//MARK: Properties
    var stock: Stock!
    
//MARK: IBOutlets
    @IBOutlet weak var stockImageView: UIImageView!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Private Methods
    fileprivate func setupViews() {
        navigationItem.title = stock.name
        stockImageView.image = kDEFAULTIMAGE
    }
    
//MARK: IBActions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//MARK: Helpers
    
}

//MARK: Extensions


