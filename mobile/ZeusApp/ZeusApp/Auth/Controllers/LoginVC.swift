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
    lazy var isLogin: Bool = true
    lazy var authTitle: String = ""
    lazy var token: String = ""
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupKeyboardNotifications()
        view.frame.origin.y = 64
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObervers()
    }
    
//MARK: Navigation
    
//MARK: Private Methods
    fileprivate func setupViews() {
//MARK: For testing purposes
        emailTextField.text = "kobe2@gmail.com"
        emailTextField.keyboardType = .emailAddress
        passwordTextField.text = "zeus"
        passwordTextField.isSecureTextEntry = true
        authTitle = isLogin ? "Login" : "Register"
        continueButton.setTitle(authTitle, for: .normal)
        continueButton.isMainButton()
        self.title = authTitle
        self.navigationController!.navigationBar.isTranslucent = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissTap(_:)))
        self.view.addGestureRecognizer(tap)
        updateColors()
    }
    
    fileprivate func updateColors() {
        self.view.backgroundColor = SettingsService.whiteColor
        self.switchButton.isClearButton()
        self.continueButton.isMainButton()
        self.emailTextField.setUnderlineColor(color: SettingsService.blackColor)
        self.passwordTextField.setUnderlineColor(color: SettingsService.blackColor)
    }
    
    
//MARK: Networking Calls
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
                    self.goToNextController()
                }
            }
        } else {
            let dic:[String: String] = [kUSERID: UUID().uuidString, kFULLNAME: "Kobe Bryant", kEMAIL: email, "password": password]
            postRequest(url: kAPIURL + "/create", userDic: dic) { (error, user) in
                DispatchQueue.main.async {
                    if let error = error {
                        Service.presentAlert(on: self, title: "Register Error", message: error); return
                    }
                    print("Registered ", user!.email)
                    saveUserLocally(user: user!)//Register currently does not return token
                    self.goToNextController(fromLogin: false)
                }
            }
        }
    }
    
///Go to HomeVC if login or QuizVC if register
    fileprivate func goToNextController(fromLogin: Bool = true) {
        switch fromLogin {
        case true: //login, go home
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: kMAINTABBARCONTROLLERID) as! MainTabBarController
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()! //instantiate MainTabBarController
            Service.presentVCWithAnimation(fromVC: self, toVC: vc)
        case false: //register, go quiz
//            let vc = UIStoryboard(name: "Quiz", bundle: nil).instantiateViewController(identifier: kPAGE1QUIZVC) as! Page1VC
            let vc = UIStoryboard(name: "Quiz", bundle: nil).instantiateInitialViewController()! //instantiate page1VC's UINavigationController
            vc.modalPresentationStyle = .fullScreen
//            self.navigationController?.initRootVC(vc: vc)
            Service.presentVCWithAnimation(fromVC: self, toVC: vc)
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
//MARK: Keyboard Helpers
extension LoginVC {
    fileprivate func setupKeyboardNotifications() { //setup notifications when keyboard shows or hide
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func removeKeyboardObervers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) { //makes the view go up by keyboard's height
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 64 {
                view.frame.origin.y -= keyboardSize.height * 0.75
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) { //put the view back to 0
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 64
        }
    }
}

