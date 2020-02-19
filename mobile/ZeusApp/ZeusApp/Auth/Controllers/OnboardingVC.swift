//
//  OnboardingVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController {
//MARK: Properties
    
//MARK: IBOutlets
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
        self.title = "My Profile"
        self.navigationController!.navigationBar.isTranslucent = false
    }
    
//MARK: IBActions
    
//MARK: Helpers
    
}

//MARK: Extensions
