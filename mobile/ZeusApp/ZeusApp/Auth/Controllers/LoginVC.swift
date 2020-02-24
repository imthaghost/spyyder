//
//  LoginVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
//MARK: Properties
    var isLogin: Bool = true
    var authTitle: String = ""
    var token = ""
    
//MARK: IBOutlets
    @IBOutlet weak var emailTextField: UnderlinedTextField!
    @IBOutlet weak var passwordTextField: UnderlinedTextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
        //MARK: For testing purposes
        emailTextField.text = "kobe@gmail.com"
        passwordTextField.text = "zeus"
        authTitle = isLogin ? "Login" : "Register"
        continueButton.setTitle(authTitle, for: .normal)
        continueButton.isMainButton()
        self.title = authTitle
        self.navigationController!.navigationBar.isTranslucent = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    fileprivate func authenticateUser() {
        guard let email = emailTextField.text?.trimmedString() else { return } //handle client side empty or invalid textField.text
        guard let password = passwordTextField.text?.trimmedString() else { return }
        if isLogin {
            login(email: email, password: password) { (error, user) in
                DispatchQueue.main.async {
                    if let error = error {
                        Service.presentAlert(on: self, title: "Login Error", message: error); return
                    }
                    print("Login, ", user!.email)
                    saveUserLocally(user: user!)
//                    let vc: MainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: kMAINTABBARCONTROLLERID) as! MainTabBarController
//                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                    self.performSegue(withIdentifier: kSEGUETOTABBAR, sender: nil)
                }
            }
        } else {
            let dic:[String: String] = [kUSERID: UUID().uuidString, kFULLNAME: "Kobe Bryant", kEMAIL: email, "password": password]
            postRequest(url: kAPIURL + "/create", userDic: dic) { (error, user) in
                DispatchQueue.main.async {
                    if let error = error {
                        Service.presentAlert(on: self, title: "Register Error", message: error); return
                    }
                    print("Registered ", user?.email)
                    saveUserLocally(user: user!)//Register currently does not return token
                    self.performSegue(withIdentifier: kSEGUETOTABBAR, sender: nil)
                }
            }
        }
    }
    
//MARK: IBActions
    @IBAction func continueButtonTapped(_ sender: Any) {
        authenticateUser()
    }
    
    @IBAction func switchButtonTapped(_ sender: Any) {
        isLogin = !isLogin
        authTitle = isLogin ? "Login" : "Register"
        self.title = authTitle
        let switchButtonTitle: String = isLogin ? "Switch to Register" : "Switch to Login"
        switchButton.setTitle(switchButtonTitle, for: .normal)
        continueButton.setTitle(authTitle, for: .normal)
    }
    
//MARK: Helpers
    @objc func handleDismissTap(_ gesture: UITapGestureRecognizer) { //dismiss fields
        self.view.endEditing(false)
    }
}

//MARK: Extensions
