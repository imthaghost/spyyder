//
//  Page4VC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/2/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class Page4VC: UIViewController {
//MARK: Properties
    
//MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
        continueButton.isMainButton()
//        self.title = "My Profile"
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

