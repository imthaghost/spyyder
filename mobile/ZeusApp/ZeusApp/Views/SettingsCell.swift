//
//  SettingsCell.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    static let identifier: String = "SettingsCell"
    let background : UIView = {
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.layer.cornerRadius = 5
        background.layer.masksToBounds = true
        return background
    }()
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.image = kDEFAULTIMAGE
        return imageView
    }()
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Profile"
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //initializer for a cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        self.accessoryType = .disclosureIndicator
        self.contentView.addSubview(background)
        background.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        background.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
//        background.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        background.addSubview(cellImageView)
        cellImageView.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10).isActive = true
        cellImageView.heightAnchor.constraint(equalTo: background.heightAnchor, multiplier: 0.8).isActive = true
        cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor).isActive = true
        background.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: cellImageView.centerYAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10).isActive = true
    }
}
