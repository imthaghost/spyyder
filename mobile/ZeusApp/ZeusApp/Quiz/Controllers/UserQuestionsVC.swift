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
    var questions: [Quiz] = []
//MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
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
        continueButton.isMainButton()
    }
    
//MARK: IBActions
    
//MARK: Helpers
    @objc func showOptions(controller: UIViewController) {
    }
}

//MARK: Extensions
extension UserQuestionsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension UserQuestionsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //for title and question cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: //if title section
            return 1
        case 1:
            return questions.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: //if title
            break
        case 1:
            let cell: UserQuestionsCell = tableView.dequeueReusableCell(withIdentifier: UserQuestionsCell.identifier, for: indexPath) as! UserQuestionsCell
            return cell
        default:
            break
        }
//        let cell: BoxCell = tableView.dequeueReusableCell(withIdentifier: BoxCell.identifier, for: indexPath) as! BoxCell
//        cell.boxLabel.text = months[indexPath.row]
//        cell.backgroundColor = SettingsService.whiteColor
//        cell.boxLabel.textColor = SettingsService.darkGrayColor
//        cell.selectionStyle = .none
        return UITableViewCell()
    }
}
