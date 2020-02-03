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
        view.backgroundColor = .black
        return view
    }()
    var descriptionView: StockDescriptionView!
    var isDescriptionView: Bool = false
//    {
////        let view: StockDescriptionView = UIView(frame: .zero)
//        let view = StockDescriptionView(stock: stock)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = kMAINCOLOR
//        return view
//    }()
    
//MARK: IBOutlets
    @IBOutlet weak var stockView: UIView!
    @IBOutlet weak var navItem: UINavigationItem!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Private Methods
    fileprivate func setupViews() {
        navItem.title = stock.name
        stockView.backgroundColor = kMAINCOLOR
        stockView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(flipStockViewTap(_:)))
        stockView.addGestureRecognizer(tap)
        
        descriptionView = StockDescriptionView(stock: stock)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
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
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
