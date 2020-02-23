//
//  Networking.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/12/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

struct UserAPI: Encodable { //sending
    let email: String
    let password: String
}

struct Token: Decodable { //receiving
    let token: String
}

struct Message: Decodable {
    let success: String
}


