//
//  Constants.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/30/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

public let kAPIURL: String = "http://3.17.150.127:8000"

//Colors //off black = 101010, offwhite = f0f0f0, dark blue = 0066e3, darker blue = 12125e,
//let kMAINCOLOR: UIColor = UIColor(hexString: "12125e", alpha: 1.0)
//let kBLUECOLOR: UIColor = UIColor(hexString: "0066e3", alpha: 1.0)
let kMAINCOLOR: UIColor = UIColor(hexString: "12125e", alpha: 1.0)
let kOFFWHITECOLOR: UIColor = UIColor(hexString: "#f0f0f0")
let kOFFBLACKCOLOR: UIColor = UIColor(hexString: "#101010")
let kGRAYCOLOR: UIColor = .gray
let kLIGHTGRAYCOLOR: UIColor = .lightGray
let kGREENCOLOR: UIColor = UIColor(hexString: "42f578", alpha: 1.0)
let kREDCOLOR: UIColor = UIColor(hexString: "bf2811", alpha: 1.0)

//MARK: Storyboard Idenfitifiers
let kMAINTABBARCONTROLLERID: String = "mainTabBarController"

//MARK: Storyboard Segues
let kSEGUETOSTOCKDETAILSVC: String = "toStockDetailVC"
let kSEGUETOQUIZVC: String = "toQuizVC"
//let kSEGUETOTABBAR: String = "toMainTabBarController"

//Images
let kDEFAULTIMAGE: UIImage = UIImage(named: "blankImage")!
let kMENUIMAGE: UIImage = UIImage(named: "menu")!

//for User model
public let kUSERID: String = "userId"
public let kFIRSTNAME: String = "firstName"
public let kLASTNAME: String = "lastName"
public let kFULLNAME: String = "fullName"
public let kEMAIL: String = "email"
public let kCREATEDAT: String = "createdAt"
public let kUPDATEDAT: String = "updatedAt"
public let kPHONENUMBER: String = "phoneNumber"
public let kSTOCKS: String = "stocks"

public let kCURRENTUSER: String = "currentUser" //for userDefaults
public let kTOKEN: String = "token"
public let kMESSAGE: String = "message"
public let kCOMPANYNAME: String = "companyname"
public let kSHORTNAME: String = "shortName"
public let kPRICE: String = "price"

//Stock
public let kTRENDINGSTOCKS: String = "trendingStocks"
public let kSUGGESTEDSTOCKS: String = "suggestedStocks"
