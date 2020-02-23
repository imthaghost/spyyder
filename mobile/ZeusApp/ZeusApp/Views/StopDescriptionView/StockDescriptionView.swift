//
//  StockDescriptionView.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/3/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class StockDescriptionView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var ceoLabel: UILabel!
    @IBOutlet weak var hqLabel: UILabel!
    @IBOutlet weak var foundedLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    
    var stock: Stock!
    
    required init(stock: Stock) {
        super.init(frame: .zero)
        commonInit()
        self.stock = stock
//        self.ceoLabel.text = stock.shortName
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("StockDescriptionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() { //where you can set
        setupBackgroundLayer()
    }
    
    fileprivate func setupBackgroundLayer() {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.white.cgColor, kMAINCOLOR.cgColor] //add colors, first one will be at the top
        gradientLayer.locations = [0.5, 1]
        self.contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
