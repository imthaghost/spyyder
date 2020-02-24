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
    var stocks: [Stock] = []

    init(_userId: String, _firstName: String = "", _lastName: String = "", _email: String = "", _phoneNumber: String = "", _createdAt: Date, _updatedAt: Date = Date(), _stocks: [Stock] = []) {
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
        if let stocks = _dictionary[kSTOCKS] as? [Stock] {
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
            let stocks = try? JSONDecoder().decode([Stock].self, from: stockData) else {
                return
        }
        self.stocks = stocks
    }
    
    func createNewStock(stock: Stock) {
        self.stocks.insert(stock, at: 0) // Prepend the stocks to the array
        self.saveStocks()
    }
    
    private func saveStocks() {
        guard let stocksData = try? JSONEncoder().encode(self.stocks) else { //decode array of stocks
            fatalError("could not encode list of stocks")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(stocksData, forKey: kSTOCKS)
        userDefaults.synchronize()
        saveUserLocally(user: self)
    }
    
    func delete(_ stockIndex: Int) {
        self.stocks.remove(at: stockIndex)
        // Persist the changes we made to our stocks array
        self.saveStocks()
    }
    
//    func markStockAsCompleted(_ stockIndex: Int) -> Stock {
//        /// Step 12: We create a variable called updatedStock that stores the stock at the given index.
//        var updatedStock = self.stocks[stockIndex]
//        /// Step 13: The next step is checking if that stock has been completed for the day. If the habit has not been completed then we increment the number of completions by 1. If it has already been completed then we return out of this function with the same habit
//        guard updatedStock.completedToday == false else { return updatedStock }
//        updatedStock.numberOfCompletions += 1
//        /// Step 14: We create a constant that is going to store the value of the current habit's last completion date With that value we check if that date was yesterday. If so then we increment the streak of the habit by 1. If the it wasn't completed yesterday we set the current streak to 1 denoting either it's a new habit or the user lost their streak on the habit
//        if let lastCompletionDate = updatedStock.lastCompletionDate, lastCompletionDate.isYesterday {
//            updatedStock.currentStreak += 1
//        } else {
//            updatedStock.currentStreak = 1
//        }
//        /// Step 15: We then check if the current streak of our chosen habit is better than that habit's best streak!
//        if updatedStock.currentStreak > updatedStock.bestStreak {
//            updatedStock.bestStreak = updatedStock.currentStreak
//        }
//        /// Step 16: It's important to update the completion date of the habit so that our previous logic is still accurate at a later time!
//        let now = Date()
//        updatedStock.lastCompletionDate = now
//        /// Step 17: We then change the chosen habit to reflect the updated habit with changes we made
//        self.habits[habitIndex] = updatedHabit
//        /// Step 18: Lastly we save our changes made to our habits array and return the newly updated habit
//        self.saveStocks()
//        return updatedStock
//    }
    
    /// Step 19: The first function takes to parameters a habitIndex and a destinationIndex representing the two indices of the habits you want to swap - We remove the current habit from it's position and insert it at the destination index - We then save the newly made changes to our habit array
//    func swapStocks(habitIndex: Int, destinationIndex: Int) {
//            let habitToSwap = self.habits[habitIndex]
//            self.habits.remove(at: habitIndex)
//            self.habits.insert(habitToSwap, at: destinationIndex)
//            self.saveStocks()
//        }

    /// Step 20: The next function comes in handy after we added a new habit and update the collection of habits present in the table view!
    func setNeedsToReloadStocks() {
        self.loadStocks()
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
    print("Current User = \(user.fullName)")
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
