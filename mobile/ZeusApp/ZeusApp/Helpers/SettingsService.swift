//
//  SettingsService.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/19/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class SettingsService {
    static var isDarkMode: Bool = false
    static var mainColor: UIColor = kMAINCOLOR
    static var blackColor: UIColor { //get only property
        return isDarkMode ? kOFFWHITECOLOR : kOFFBLACKCOLOR
    }
    static var whiteColor: UIColor  {
        return isDarkMode ? kOFFBLACKCOLOR : kOFFWHITECOLOR
    }
///whites that will turn gray on dark mode
    static var grayColor: UIColor {
        return isDarkMode ? .lightGray : kOFFWHITECOLOR
    }
/// black that will turn gray on darkmode
    static var darkGrayColor: UIColor {
        return isDarkMode ? .lightGray : kOFFBLACKCOLOR
    }
    static var redColor: UIColor {
        return kREDCOLOR
    }
    static var greenColor: UIColor {
        return kGREENCOLOR
    }
    
    static func isMainTabBar(tabBar: inout UITabBar) {
//        tabBar.layer.masksToBounds = true
//        tabBar.layer.cornerRadius = 20
//        tabBar.barStyle = .black
        //MARK: Color customization
//        tabBar.backgroundColor = .clear
//        tabBar.backgroundImage = UIImage()
        tabBar.barTintColor = SettingsService.mainColor //bar color
        tabBar.tintColor = SettingsService.whiteColor //selected tab
        tabBar.unselectedItemTintColor = .gray
    }
    
    static func isXSmallLabel(label: inout UILabel, color: UIColor = SettingsService.whiteColor, weight: UIFont.Weight = .thin) {
        label.font = UIFont.systemFont(ofSize: 9, weight: weight)
        label.textColor = color
    }
    static func isSmallLabel(label: inout UILabel, color: UIColor = SettingsService.whiteColor, weight: UIFont.Weight = .regular) {
        label.font = UIFont.systemFont(ofSize: 12, weight: weight)
        label.textColor = color
    }
    static func isMediumLabel(label: inout UILabel, color: UIColor = SettingsService.whiteColor, weight: UIFont.Weight = .regular) {
        label.font = UIFont.systemFont(ofSize: 18, weight: weight)
        label.textColor = color
    }
    static func isLargeLabel(label: inout UILabel, color: UIColor = SettingsService.whiteColor, weight: UIFont.Weight = .bold) {
        label.font = UIFont.systemFont(ofSize: 28, weight: weight)
        label.textColor = color
    }
    static func isXLargeLabel(label: inout UILabel, color: UIColor = SettingsService.whiteColor, weight: UIFont.Weight = .bold) {
        label.font = UIFont.systemFont(ofSize: 36, weight: weight)
        label.textColor = color
    }
}
