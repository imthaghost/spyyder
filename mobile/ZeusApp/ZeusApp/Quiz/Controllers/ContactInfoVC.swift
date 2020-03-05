//
//  ContactInfoVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/2/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class ContactInfoVC: UIViewController {
//MARK: Properties
    
//MARK: IBOutlets
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var address1TextField: UnderlinedTextField!
    @IBOutlet weak var address2TextField: UnderlinedTextField!
    @IBOutlet weak var cityTextField: UnderlinedTextField!
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
        self.title = "Contact Information"
        continueButton.isMainButton()
        continueButton.setTitle("Finish", for: .normal)
        address1TextField.placeholder = "Address 1"
        address2TextField.placeholder = "Address 2"
        cityTextField.placeholder = "City"
//        self.navigationController!.navigationBar.isTranslucent = false
//        table.register(BoxCell.self, forCellReuseIdentifier: BoxCell.identifier)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(showOptions(controller:)))
    }
    
//MARK: IBActions
    @IBAction func continueButtonTapped(_ sender: Any) {
        let vc: MainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: kMAINTABBARCONTROLLERID) as! MainTabBarController
        Service.presentVCWithAnimation(fromVC: self, toVC: vc)
    }
    
//MARK: Helpers
    @objc func showOptions(controller: UIViewController) {
    }
}

//MARK: Extensions

