//
//  Quiz.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 3/1/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct Quiz { //singleton quiz model
    static let shared = Quiz()
    var name: String?
    var data: [String: Any] = [:]

    private init() { }
}
