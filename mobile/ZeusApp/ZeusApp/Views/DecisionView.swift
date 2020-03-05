//
//  DescriptionView.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/20/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class DecisionView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var whyModel: WhyModel!
    
    required init(whyModel: WhyModel) {
        super.init(frame: .zero)
        self.whyModel = whyModel
        commonInit()
        populateViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        populateViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        populateViews()
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("StockDescriptionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func populateViews() {
        titleLabel.text = whyModel.title
        descriptionLabel.text = whyModel.description
    }
    
//    override func layoutSubviews() { //where you can set
//        setupBackgroundLayer()
//    }
    
//    fileprivate func setupBackgroundLayer() {
//        let gradientLayer: CAGradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.bounds
//        gradientLayer.colors = [UIColor.white.cgColor, kMAINCOLOR.cgColor] //add colors, first one will be at the top
//        gradientLayer.locations = [0.5, 1]
//        self.contentView.layer.insertSublayer(gradientLayer, at: 0)
//
//    }
}

