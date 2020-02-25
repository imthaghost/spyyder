//
//  StockDetailsVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import Charts

struct WhyModel {
    let title: String
    let description: String
}

protocol StockDetailProtocol {
    /* parameters here is what the parent class will receive */
    func didUpdateStock(stock: Stock)
}

class StockDetailsVC: UIViewController {
//MARK: Properties
    var user: User!
    var delegate: StockDetailProtocol!
    var stock: Stock!
    lazy var dummyWhyData: [WhyModel] = [
        WhyModel(title: "Because Trump sold all his \(stock.name) shares", description: "sdjsfj sljfksjkf sjfklsjf "),
        WhyModel(title: "\(stock.name) release an update", description: "Update your app and invest ment"),
        WhyModel(title: "Tesla increase may affect \(stock.name) prices", description: "sdjsfj sljfksjkf sjfklsjf "),
        WhyModel(title: "\(stock.name) raise $5 million on 2nd round", description: "Update your app and invest ment")
    ]
    
//MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pricePercentLabel: UILabel!
    @IBOutlet weak var predictedLabel: UILabel!
    @IBOutlet weak var predictedPercentLabel: UILabel!
    @IBOutlet weak var graphView: LineChartView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var month3Button: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var year5Button: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var decisionStackView: UIStackView!
    @IBOutlet weak var decisionLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var ceoLabel: UILabel!
    @IBOutlet weak var headquartersLabel: UILabel!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//MARK: Private Methods
    fileprivate func setupViews() {
        if let user = getCurrentUser() {
            self.user = user
            self.followButton.isHidden = false
        } else {
            self.followButton.isHidden = true
        }
//        self.title = stock.name
        self.navigationController!.navigationBar.isTranslucent = false
        setupFollowButton()
        setupTopLabels()
        populateWhyStackView()
        setupDescriptionView()
    }
    
    fileprivate func setupDescriptionView() {
        ceoLabel.text = "\(stock.name) CEO"
        volumeLabel.text = "1,400,398"
        headquartersLabel.text = "San Francisco, CA"
    }
    
    fileprivate func populateWhyStackView() {
        for whyData in dummyWhyData { //add to decision stack a view with title and decriptions each news from whyData'
            let label = UILabel(frame: .zero)
            label.text = "• " + whyData.title
            decisionStackView.addArrangedSubview(label)
        }
    }
    
    fileprivate func setupTopLabels() {
        SettingsService.isXLargeLabel(label: &nameLabel)
        SettingsService.isMediumLabel(label: &priceLabel, color: SettingsService.greenColor)
        SettingsService.isSmallLabel(label: &pricePercentLabel, color: SettingsService.greenColor)
        SettingsService.isMediumLabel(label: &predictedLabel, color: SettingsService.mainColor)
        SettingsService.isSmallLabel(label: &predictedPercentLabel, color: SettingsService.mainColor)
        nameLabel.text = stock.name
        priceLabel.text = "$1078.32"
        pricePercentLabel.text = "+25%"
        predictedLabel.text = "$1203.98"
        predictedPercentLabel.text = "+34%"
    }
    
    fileprivate func setupFollowButton() {
        followButton.isMainButton()
        updateFollowButton(senderIsButton: false)
    }
    
///update follow button. If it's a setup, then update title. If it's not a setup, delete or create stock in user
    fileprivate func updateFollowButton(senderIsButton: Bool) {
        var buttonTitle: String = ""
        let index = user.getStockIndex(stock: stock) //get index of stock
        if stock.isFollowing { //stock is in favorites
            buttonTitle = "Unfollow"
            if senderIsButton { //if it is not initial set up, meaning user tapped on button
                user.createNewStock(stock: stock)
            }
        } else {
            buttonTitle = "Follow"
            if senderIsButton { //if user tapped unfollow button
                user.deleteStock(index)
            }
        }
        followButton.setTitle(buttonTitle, for: .normal)
    }
    
//MARK: IBActions
    @IBAction func followButtonTapped(_ sender: UIButton) {
        stock.isFollowing = !stock.isFollowing
        updateFollowButton(senderIsButton: true)
    }
    @IBAction func dateButtonTap(_ sender: UIButton) {
        if sender == dayButton {
            print("Day 1")
        } else if sender == weekButton {
            print("Week 1")
        }
        else if sender == monthButton {
            print("Month 1")
        }
        else if sender == month3Button {
            print("Month 3")
        }
        else if sender == yearButton {
            print("Year 1")
        }
        else if sender == year5Button {
            print("Year 5")
        }
        else if sender == allButton {
            print("All")
        }
    }
    
//MARK: Helpers
}

//MARK: Extensions
