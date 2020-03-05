//
//  UIButton+extensions.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIButton {
    func isMainButton() { //applied border width and rounded corners
//        self.layer.borderWidth = 2
//        self.layer.borderColor = SettingsService.blackColor.cgColor
        self.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        self.backgroundColor = SettingsService.mainColor
        self.setTitleColor(SettingsService.whiteColor, for: .normal)
        self.layer.cornerRadius = self.frame.height / 4
        self.clipsToBounds = true
    }
    
    func isWhiteButton() { //applied border width and rounded corners
        self.layer.borderWidth = 2
        self.layer.borderColor = SettingsService.blackColor.cgColor
        self.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        self.backgroundColor = SettingsService.whiteColor
        self.setTitleColor(SettingsService.blackColor, for: .normal)
        self.layer.cornerRadius = self.frame.height / 4
        self.clipsToBounds = true
    }
    
    func isDateButton() { //applied border width and rounded corners
//        self.layer.borderWidth = 2
//        self.layer.borderColor = SettingsService.blackColor.cgColor
        self.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
        self.backgroundColor = .clear
        self.setTitleColor(SettingsService.whiteColor, for: .normal)
        self.layer.cornerRadius = self.frame.height / 4
        self.clipsToBounds = true
    }
    
    func isClearButton(titleColor: UIColor = SettingsService.mainColor) {
        self.backgroundColor = .clear
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = titleColor.cgColor
    }
}
