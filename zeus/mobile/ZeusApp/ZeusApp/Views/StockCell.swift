//
//  StockCell.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/30/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {
    
    var stock: Stock!
    
    @IBOutlet weak var stockImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func populateViews() {
//        stockImageView.downloaded(fromLink: mail.imageUrl)
        stockImageView.image = kDEFAULTIMAGE
        nameLabel.text = stock.name
    }
}
