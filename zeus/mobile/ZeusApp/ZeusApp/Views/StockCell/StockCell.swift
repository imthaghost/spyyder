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
    @IBOutlet weak var stockImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func populateViews(showRank: Bool) {
//        stockImageView.downloaded(fromLink: mail.imageUrl)
        rankLabel.isHidden = showRank ? false : true
        stockImageView.image = kDEFAULTIMAGE
        nameLabel.text = stock.name
        categoryLabel.text = "Technology"
        riskLabel.text = "High Risk"
    }
}
