//
//  User.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class User: NSObject {
    let userId: String
    var firstName: String
    var lastName: String
    var fullName: String
    var email: String
    var phoneNumber: String
    let createdAt: Date
    var updatedAt: Date
    var stocks: [String] = []

    init(_userId: String, _firstName: String = "", _lastName: String = "", _email: String = "", _phoneNumber: String = "", _createdAt: Date, _updatedAt: Date = Date(), _stocks: [String] = []) {
        userId = _userId
        firstName = _firstName
        lastName = _lastName
        fullName = assignFullName(fName: _firstName, lName: _lastName)
        email = _email
        phoneNumber = _phoneNumber
        createdAt = _createdAt
        updatedAt = _updatedAt
        stocks = _stocks
    }
    
    init(_dictionary: [String: Any]) {
        self.userId = _dictionary[kUSERID] as! String
        self.firstName = _dictionary[kFIRSTNAME] as? String ?? ""
        self.lastName = _dictionary[kLASTNAME] as? String ?? ""
        if let fullName = _dictionary[kFULLNAME] as? String {
            self.fullName = fullName
        } else {
            self.fullName = assignFullName(fName: self.firstName, lName: self.lastName)
        }
        self.email = _dictionary[kEMAIL] as! String
        if let phoneNumber = _dictionary[kPHONENUMBER] as? String {
            self.phoneNumber = phoneNumber
        } else {
            self.phoneNumber = ""
        }
        if let createdAt = _dictionary[kCREATEDAT] { //if we have this date, then apply it to the user, else create new current instance of Date()
            self.createdAt = Service.dateFormatter().date(from: createdAt as! String)!
        } else {
            self.createdAt = Date()
        }
        if let updatedAt = _dictionary[kUPDATEDAT] { //if we have this date, then apply it to the user, else create new current instance of Date()
            self.updatedAt = Service.dateFormatter().date(from: updatedAt as! String)!
        } else {
            self.updatedAt = Date()
        }
        if let stocks = _dictionary[kSTOCKS] as? [String] {
            self.stocks = stocks
        }
    }
    
    deinit {
        print("User \(self.fullName) is being deinitialize.")
    }
    
//MARK: Class Functions
    private func loadStocks() {
        let userDefaults = UserDefaults.standard
        guard
            let stockData = userDefaults.data(forKey: kSTOCKS),
            let stocksDecoded = try? JSONDecoder().decode([Stock].self, from: stockData) else { //decode stockData
                return
        }
        for stock in stocksDecoded {
            self.stocks.append(stock.name)
        }
    }
    
///create new stock, or delete if it exist and reappend it
    func createNewStock(stock: Stock) {
        let stockIndex = getStockIndex(stock: stock)
        if stockIndex != -1 { //if stock exist in our stocks...
            deleteStock(stockIndex)
        }
        self.stocks.insert(stock.name, at: 0) // Prepend the stocks to the array
        self.saveStocks()
    }
    
///Get the index of stock in user's stocks
    func getStockIndex(stock: Stock) -> Int {
        var index: Int = -1
        if stocks.contains(stock.name) { //stock must conform to Equatable
            for (stockIndex, favStock) in stocks.enumerated() where stock.name == favStock { //loop through each user's stocks until stock.name
                index = stockIndex
            }
        }
        return index
    }
    
    private func saveStocks() {
        guard let stocksData = try? JSONEncoder().encode(self.stocks) else { //encode array of stocks
            fatalError("could not encode list of stocks")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(stocksData, forKey: kSTOCKS)
        userDefaults.synchronize()
        saveUserLocally(user: self)
    }
    
    func deleteStock(_ stockIndex: Int) {
        self.stocks.remove(at: stockIndex)
        // Persist the changes we made to our stocks array
        self.saveStocks()
    }

    func setNeedsToReloadStocks() {
        self.loadStocks()
    }
    
    func getUserStocks() -> [Stock] {
        var userStocks: [Stock] = []
        let allStocks: [Stock] = loadAllStocks() //load all stocks
        for favStockName in self.stocks {
            if let i = allStocks.firstIndex(where: { $0.name == favStockName }) { //find the index of each stocks in allStocks
                userStocks.append(allStocks[i])
            }
        }
        print("USER STOCKS ARE = \(userStocks)")
        return userStocks
    }
}

//MARK: Helper Methods for User
func userDictionaryFrom(user: User) -> NSDictionary { //take a user and return an NSDictionary, convert dates into strings
    let createdAt = Service.dateFormatter().string(from: user.createdAt) //convert dates to strings first
    let updatedAt = Service.dateFormatter().string(from: user.updatedAt)
    return NSDictionary(
        objects: [user.userId, user.firstName, user.lastName, user.fullName, user.email, user.phoneNumber, createdAt, updatedAt, user.stocks],
        forKeys: [kUSERID as NSCopying, kFIRSTNAME as NSCopying, kLASTNAME as NSCopying, kFULLNAME as NSCopying, kEMAIL as NSCopying, kPHONENUMBER as NSCopying, kCREATEDAT as NSCopying, kUPDATEDAT as NSCopying, kSTOCKS as NSCopying])
}

///returns full name if first name and last name is not empty
func assignFullName(fName: String, lName: String) -> String {
    if fName.trimmedString() != "" && lName.trimmedString() != "" {
        return "\(fName) \(lName)"
    } else {
        return ""
    }
}



//func saveProfileImage(id: String = kPROFILEIMAGE, profileImage: UIImage) {
//    let imageData: Data = profileImage.jpegData(compressionQuality: 0.2)!
//    UserDefaults.standard.set(imageData, forKey: id)
//    UserDefaults.standard.synchronize()
//}

//func loadProfileImage(id: String = kPROFILEIMAGE) -> UIImage? {
//    return UIImage(data: UserDefaults.standard.data(forKey: id)!)
//}

//func deleteProfileImage(id: String = kPROFILEIMAGE) {
//    UserDefaults.standard.removeObject(forKey: id)
//    UserDefaults.standard.synchronize()
//}

//MARK: Create/Save User
func saveUserLocally(user: User) { //save user to UserDefaults
    UserDefaults.standard.set(userDictionaryFrom(user: user), forKey: kCURRENTUSER)
    UserDefaults.standard.synchronize()
    print("Finished saving user \(user.fullName) locally...")
}

//MARK: Update User
func getCurrentUser() -> User? {
    guard let userDic = UserDefaults.standard.object(forKey: kCURRENTUSER) as? [String: Any] else { return nil }
    let user = User(_dictionary: userDic)
    print("Current User = \(user.email)")
    return user
}

//MARK: Update User
func updateCurrentUser(withValues: [String : Any], completion: @escaping(_ error: String?) -> Void) {
    if UserDefaults.standard.object(forKey: kCURRENTUSER) != nil {
        guard let currentUser = getCurrentUser() else {
            completion("Found no current user"); return }
        let userObject = userDictionaryFrom(user: currentUser).mutableCopy() as! NSMutableDictionary
        userObject.setValuesForKeys(withValues)
        UserDefaults.standard.set(userObject, forKey: kCURRENTUSER)
        UserDefaults.standard.synchronize()
        completion(nil)
        return
    }
    completion("Found no current user")
}

func deleteCurrentUser() {
    UserDefaults.standard.removeObject(forKey: kCURRENTUSER)
    UserDefaults.standard.removeObject(forKey: kSTOCKS)
    UserDefaults.standard.synchronize()
    print("Current user deleted")
}
