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
        
        
        //MARK: Remove this
        let button = UIButton(frame: .zero)
        
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
        emailTextField.text = "kobe@gmail.com"
        passwordTextField.text = "zeus"
        authTitle = isLogin ? "Login" : "Register"
        continueButton.setTitle(authTitle, for: .normal)
        continueButton.isMainButton()
        self.title = authTitle
        self.navigationController!.navigationBar.isTranslucent = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissTap(_:)))
        self.view.addGestureRecognizer(tap)
        updateColors()
        setupQuizButton()
    }
    
    fileprivate func setupQuizButton() {
        let quizButton: UIButton = UIButton(type: .custom)
        quizButton.isClearButton()
        quizButton.translatesAutoresizingMaskIntoConstraints = false
        quizButton.setTitle("Quiz", for: .normal)
        quizButton.imageView?.contentMode = .scaleAspectFill //contentMode for buttons
        quizButton.contentMode = .left
        //        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        quizButton.contentHorizontalAlignment = .left //push contents to the left
        
        view.addSubview(quizButton)
        NSLayoutConstraint.activate([
            quizButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             quizButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//            quizButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            quizButton.heightAnchor.constraint(equalToConstant: 40),
            quizButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        quizButton.addTarget(self, action: #selector(self.quizButtonTapped), for: .touchUpInside)
    }
    
    @objc func quizButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
        print("EYOOO")
        
//        navigationController?.initRootVC(vc: QuizVC())
        self.navigationController?.pushViewController(QuizVC(), animated: true)
//        self.present(QuizVC(), animated: true, completion: nil)
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
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: kMAINTABBARCONTROLLERID) as! MainTabBarController
                    self.present(vc, animated: true, completion: nil)
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
                    //self.performSegue(withIdentifier: kSEGUETOTABBAR, sender: nil)
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: kMAINTABBARCONTROLLERID) as! MainTabBarController
                    self.present(vc, animated: true, completion: nil)
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

