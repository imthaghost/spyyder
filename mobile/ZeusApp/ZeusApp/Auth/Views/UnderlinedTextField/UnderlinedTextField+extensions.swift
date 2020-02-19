//
//  UnderlinedTextField+extensions.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

extension UnderlinedTextField {
//    @discardableResult
    func hasError() {
        self.setUnderlineColor(color: .systemRed)
    }
//    @discardableResult
    func hasNoError() {
        self.setDefaultUnderlineColor()
    }
}

