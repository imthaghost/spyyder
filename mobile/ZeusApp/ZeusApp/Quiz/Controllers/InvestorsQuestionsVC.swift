//
//  InvestorsQuestionsVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/2/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class InvestorsQuestionsVC: UIViewController {
//MARK: Properties
    
//MARK: IBOutlets
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var q1Label: UILabel!
    @IBOutlet weak var q2Label: UILabel!
    @IBOutlet weak var q3Label: UILabel!
    @IBOutlet weak var q4Label: UILabel!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch4: UISwitch!
    @IBOutlet weak var continueButton: UIButton!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
        self.title = "Investor Questions"
        
    }
    
//MARK: IBActions
    
//MARK: Helpers
    @objc func showOptions(controller: UIViewController) {
    }
}

//MARK: Extensions

