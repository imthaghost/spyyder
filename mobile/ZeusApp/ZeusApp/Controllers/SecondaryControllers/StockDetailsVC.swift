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
    let graphView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = SettingsService.blackColor
        return view
    }()
//    let whyBGView : UIView = {
//            let background = UIView()
//            background.translatesAutoresizingMaskIntoConstraints = false
//        background.backgroundColor = .clear
////        background.backgroundColor = #colorLiteral(red: 0.8186396956, green: 0.7955000997, blue: 1, alpha: 1)
////            background.layer.cornerRadius = 5
////            background.layer.masksToBounds = true
//            return background
//        }()
//    lazy var whyTitleLabel: UILabel = {
//        let label: UILabel = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        label.sizeToFit()
//        label.numberOfLines = 0
//        label.textColor = .black
//        label.textAlignment = .left
////        label.text = "Box"
//        return label
//    }()
//    let whyDescriptionLabel: UILabel = {
//        let label: UILabel = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        label.sizeToFit()
//        label.numberOfLines = 0
//        label.textColor = .gray
//        label.textAlignment = .left
////        label.text = "Box"
//        return label
//    }()
//    lazy var whyStackView: UIStackView = {
//        let stackView: UIStackView = UIStackView(frame: .zero)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.alignment = .leading
//        stackView.distribution = .fill
//        stackView.spacing = 2
//        return stackView
//    }()
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
//        self.title = stock.name
        nameLabel.text = stock.name
        self.navigationController!.navigationBar.isTranslucent = false
        setupStockView()
        setupFollowButton()
        setupTopLabels()
//        populateWhyStackView()
        ceoLabel.text = "CEOOO"
    }
    
//    fileprivate func populateWhyStackView() {
//        let dummyWhyData: [WhyModel] = [WhyModel(title: "Because Trump sold it", description: "sdjsfj sljfksjkf sjfklsjf "), WhyModel(title: "Release an update", description: "Update your app and invest ment"), WhyModel(title: "Because Trump sold it", description: "sdjsfj sljfksjkf sjfklsjf "), WhyModel(title: "Release an update", description: "Update your app and invest ment")]
////        decisionStackView.addArrangedSubview(whyStackView) //create stack
//        for whyData in dummyWhyData { //add to decision stack a view with title and decriptions each news from whyData
//            let whyView = DecisionView(whyModel: whyData)
//            decisionStackView.addArrangedSubview(whyView)
////            whyStackView.addArrangedSubview(whyView)
//            NSLayoutConstraint.activate([
//                whyView.widthAnchor.constraint(equalTo: self.decisionStackView.widthAnchor),
//                whyView.heightAnchor.constraint(equalToConstant: 100
//                )
//            ])
////            let titleLabel = whyTitleLabel
////            decisionStackView.addArrangedSubview(titleLabel)
////            titleLabel.text = whyData.title
////            NSLayoutConstraint.activate([
////                titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
////                titleLabel.heightAnchor.constraint(equalToConstant: 30),
////                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
////                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
////                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
////            ])
////            let descriptionLabel = whyDescriptionLabel
////            decisionStackView.addArrangedSubview(descriptionLabel)
////            descriptionLabel.text = whyData.description
////            NSLayoutConstraint.activate([
////                descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
////                descriptionLabel.heightAnchor.constraint(equalToConstant: 30),
////                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
////                descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
////                descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
////                descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
////            ])
//        }
//    }
    
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
    
    fileprivate func setupStockView() {
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
