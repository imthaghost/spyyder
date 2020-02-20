//
//  StockDetailsVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class StockDetailsVC: UIViewController {
//MARK: Properties
    var stock: Stock!
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
        self.title = stock.name
        self.navigationController!.navigationBar.isTranslucent = false
        setupStockView()
        setupFollowButton()
    }
    
    fileprivate func setupFollowButton() {
        followButton.setTitle("Follow", for: .normal)
//        followButton.setfo
        followButton.isMainButton()
    }
    
    fileprivate func setupStockView() {
        stockView.backgroundColor = kMAINCOLOR
        stockView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(flipStockViewTap(_:)))
        stockView.addGestureRecognizer(tap)
        
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
    }
    
//MARK: Helpers
    @objc func flipStockViewTap(_ gesture: UITapGestureRecognizer) { //dismiss fields
        //        stockView.endEditing(false)
        isDescriptionView = !isDescriptionView
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: graphView, duration: 0.5, options: transitionOptions, animations: {
            self.graphView.isHidden = self.isDescriptionView
        })
        
        UIView.transition(with: descriptionView, duration: 0.5, options: transitionOptions, animations: {
            self.descriptionView.isHidden = !self.isDescriptionView
        })
    }
}

//MARK: Extensions
