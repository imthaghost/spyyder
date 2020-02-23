//
//  StockDetailsVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct WhyModel {
    let title: String
    let description: String
}

class StockDetailsVC: UIViewController {
//MARK: Properties
    var stock: Stock!
    let dummyWhyData: [WhyModel] = [WhyModel(title: "Because Trump sold it", description: "sdjsfj sljfksjkf sjfklsjf "), WhyModel(title: "Release an update", description: "Update your app and invest ment"), WhyModel(title: "Because Trump sold it", description: "sdjsfj sljfksjkf sjfklsjf "), WhyModel(title: "Release an update", description: "Update your app and invest ment")]
    let graphView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = SettingsService.blackColor
        return view
    }()
    var descriptionView: StockDescriptionView!
    var isDescriptionView: Bool = false
    
//MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pricePercentLabel: UILabel!
    @IBOutlet weak var predictedLabel: UILabel!
    @IBOutlet weak var predictedPercentLabel: UILabel!
    @IBOutlet weak var stockView: UIView!
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
    
//MARK: Private Methods
    fileprivate func setupViews() {
        nameLabel.text = stock.name
        self.navigationController!.navigationBar.isTranslucent = false
        setupStockView()
        setupFollowButton()
        setupTopLabels()
        ceoLabel.text = "Mr. CEO"
        populateDecisionStack()
    }
    
    fileprivate func populateDecisionStack() {
        decisionStackView.spacing = 10
        for whyData in dummyWhyData { //add to decision stack a view with title and decriptions each news from whyData'
            let label = UILabel(frame: .zero)
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.widthAnchor.constraint(equalTo: decisionStackView.widthAnchor, constant: -10).isActive = true
            label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            label.text = "• " + whyData.title
            decisionStackView.addArrangedSubview(label)
        }
    }
    
    fileprivate func setupTopLabels() {
        nameLabel.textColor = SettingsService.blackColor
        nameLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        priceLabel.textColor = SettingsService.greenColor
        priceLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        priceLabel.text = "$1078.32"
        pricePercentLabel.textColor = SettingsService.greenColor
        pricePercentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        pricePercentLabel.text = "+25%"
        predictedLabel.textColor = SettingsService.mainColor
        predictedLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        predictedLabel.text = "$1203.98"
        predictedPercentLabel.textColor = SettingsService.mainColor
        predictedPercentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        predictedPercentLabel.text = "+34%"
    }
    
    fileprivate func setupFollowButton() {
        followButton.setTitle("Follow", for: .normal)
        followButton.isMainButton()
    }
    
    fileprivate func setupStockView() { //setup stock view graph
        stockView.backgroundColor = kMAINCOLOR
        stockView.isUserInteractionEnabled = true
        descriptionView = StockDescriptionView(stock: stock)
        stockView.addSubview(descriptionView)
        NSLayoutConstraint.activate(
            descriptionView.pinToEdges(view: self.stockView) //pin to edges of stockView
        )
        stockView.addSubview(graphView)
        NSLayoutConstraint.activate(
            graphView.pinToEdges(view: self.stockView)
        )
        descriptionView.isHidden = false
    }
    
//MARK: IBActions
    @IBAction func followButtonTapped(_ sender: UIButton) {
        print("Add to Follow")
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
