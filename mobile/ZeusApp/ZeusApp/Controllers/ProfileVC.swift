//
//  ProfileVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
//MARK: Properties
    
//MARK: IBOutlets
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
        self.title = "My Profile"
        self.view.backgroundColor = SettingsService.blackColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = SettingsService.grayColor //button color
        navigationController?.setStatusBarColor(backgroundColor: kMAINCOLOR)
        //        table.register(BoxCell.self, forCellReuseIdentifier: BoxCell.identifier)
        table.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(showOptions(controller:)))
    }
    
//MARK: IBActions
    
//MARK: Helpers
    @objc func showOptions(controller: UIViewController) {
        let vc: SettingsVC = SettingsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Extensions
extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return months.count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: BoxCell = tableView.dequeueReusableCell(withIdentifier: BoxCell.identifier, for: indexPath) as! BoxCell
//        cell.boxLabel.text = months[indexPath.row]
//        cell.backgroundColor = SettingsService.whiteColor
//        cell.boxLabel.textColor = SettingsService.darkGrayColor
//        cell.selectionStyle = .none
        return UITableViewCell()
    }
}
