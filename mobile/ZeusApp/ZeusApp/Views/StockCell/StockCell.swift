//
//  StockCell.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/1/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {
    
//MARK: Properties
    var stock: Stock!
    
//MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var riskLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func populateViews(showRank: Bool) {
        setupBgView()
        setupLabels()
        rankLabel.isHidden = showRank ? false : true
        rankLabel.text = showRank ? String(stock.rank) : ""
//        priceLabel.text = "+999.99"
        priceLabel.text = "$\(stock.price)"
        nameLabel.text = stock.name
        categoryLabel.text = "Technology"
        riskLabel.text = "High Risk"
    }
    
    fileprivate func setupBgView() {
        bgView.layer.cornerRadius = bgView.frame.height / 4
        self.clipsToBounds = true
        bgView.backgroundColor = UIColor(hexString: "#2b2b30")
    }
    
    fileprivate func setupLabels() {
        rankLabel.textColor = SettingsService.grayColor
        rankLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        nameLabel.textColor = SettingsService.grayColor
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        priceLabel.textColor = SettingsService.greenColor
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        categoryLabel.textColor = SettingsService.grayColor
        categoryLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        riskLabel.textColor = SettingsService.redColor
        riskLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
}
