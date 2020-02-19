//
//  UITextField+extensions.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/14/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UITextField {
    
    func isEmailTextField() {
        self.keyboardType = .emailAddress
    }
    
    func isPasswordTextField() {
        self.isHidden = false
        self.isSecureTextEntry = true
        self.keyboardType = .default
        self.text = ""
        self.placeholder = "Password"
    }
    
    func isPhoneTextField() {
        self.keyboardType = .phonePad
    }
    
    func isPhoneCodeTextField(isHidden: Bool) {
        self.keyboardType = .numberPad
        self.isSecureTextEntry = false
        if isHidden {
            self.isHidden = true
        } else {
            self.isHidden = true
        }
    }
}
