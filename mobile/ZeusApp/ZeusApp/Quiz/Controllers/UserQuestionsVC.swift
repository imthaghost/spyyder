//
//  UserQuestionsVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/2/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class UserQuestionsVC: UIViewController {
//MARK: Properties
    
//MARK: IBOutlets
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
        self.title = "Find the Right Portfolio"
        self.navigationController!.navigationBar.isTranslucent = false
//        table.register(BoxCell.self, forCellReuseIdentifier: BoxCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
//MARK: IBActions
    
//MARK: Helpers
    @objc func showOptions(controller: UIViewController) {
        let vc: SettingsVC = SettingsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Extensions
extension UserQuestionsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension UserQuestionsVC: UITableViewDataSource {
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
