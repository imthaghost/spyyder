//
//  UserPortfolioVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/2/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import Charts

class UserPortfolioVC: UIViewController {
//MARK: Properties
    
//MARK: IBOutlets
    
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
        self.title = "Your Portfolio"
        continueButton.isMainButton()
        continueButton.setTitle("Next", for: .normal)
//        self.navigationController!.navigationBar.isTranslucent = false
//        table.register(BoxCell.self, forCellReuseIdentifier: BoxCell.identifier)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(showOptions(controller:)))
    }
    
//MARK: IBActions
    
//MARK: Helpers
    @objc func showOptions(controller: UIViewController) {
    }
}

//MARK: Extensions

