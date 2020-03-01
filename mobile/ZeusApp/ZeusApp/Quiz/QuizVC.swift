//
//  QuizVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/1/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class QuizVC: UIViewController {
//MARK: Properties
    
//MARK: IBOutlets
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var continueButton: UIButton!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Private Methods
    fileprivate func updateColors() {
        continueButton.isMainButton()
    }
    
    fileprivate func setupViews() {
        continueButton.setTitle("Next", for: .normal)
        mainStackView.alignment = .fill
        mainStackView.axis = .horizontal
        
        updateColors()
    }
    
    fileprivate func setupNavigationBar() {
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//MARK: Helpers
}

//MARK: Extensions
