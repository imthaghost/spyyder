//
//  SettingsVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct SettingsData {
    let title: String
    let image: UIImage
}

class SettingsVC: UIViewController {
//MARK: Properties
    let settingsData: [SettingsData] = [SettingsData(title: "Profile", image: kDEFAULTIMAGE), SettingsData(title: "Retake Quiz", image: kDEFAULTIMAGE), SettingsData(title: "Account Settings", image: kDEFAULTIMAGE), SettingsData(title: "Help & Support", image: kDEFAULTIMAGE), SettingsData(title: "Settings & Privacy", image: kDEFAULTIMAGE), SettingsData(title: "Logout", image: kDEFAULTIMAGE), ]
//MARK: View Properties
    let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = 75
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
        self.title = "Settings"
        self.view.backgroundColor = SettingsService.whiteColor
//        self.navigationController!.navigationBar.isTranslucent = false
        setupTableView()
    }
    
    fileprivate func setupTableView(){
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        table.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        table.tableFooterView = UIView()
    }
    
//MARK: Helpers
}

//MARK: Extensions
extension SettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let vc = UIStoryboard(name: "Quiz", bundle: nil).instantiateInitialViewController()! //instantiate page1VC's UINavigationController
            vc.modalPresentationStyle = .fullScreen
            Service.presentVCWithAnimation(fromVC: self, toVC: vc)
        case settingsData.count - 1: //if last/logout
            deleteCurrentUser()
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()!
            Service.presentVCWithAnimation(fromVC: self, toVC: vc, fromRight: false) // --> side animation to loginVC
        default:
            break
        }
    }
}

extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsCell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as! SettingsCell
        let data = settingsData[indexPath.row]
        cell.titleLabel.text = data.title
        cell.cellImageView.image = data.image
        cell.selectionStyle = .none
        return cell
    }
}
