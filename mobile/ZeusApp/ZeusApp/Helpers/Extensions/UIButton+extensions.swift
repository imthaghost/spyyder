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
//        self.layer.borderColor = UIColor.white.cgColor
        self.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        self.backgroundColor = kMAINCOLOR
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = self.frame.height / 4
        self.clipsToBounds = true
    }
}
