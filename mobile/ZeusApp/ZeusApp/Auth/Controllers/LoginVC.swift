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
    
    fileprivate func register(email: String, password: String) {
        let dic:[String: String] = [
            "fullname": "Kobe Bryant",
            "email": email,
            "password": password
        ]
        postRequest(url: "/create", dic: dic)
    }
    
    fileprivate func login(email: String, password: String) {
        let dic:[String: String] = [
            "email": email,
            "password": password,
        ]
        if (!JSONSerialization.isValidJSONObject(dic)) {
            print("is not a valid json object")
            return
        }
        let session = URLSession.shared
        let url = "http://3.17.150.127:8000/login"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print ("status code = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(Token.self, from: data)
                        print(response.token)
                        self.token = response.token
                    } catch {
                        print(error)
                    }
//                    do {
//                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
//                        print ("jsonResponse: \(jsonResponse)")
////                        if let token = jsonResponse["token"] as? String {
////                            print(token)
////                        }
//                    } catch _ {
//                        print ("JSON not formatted")
//                    }
                }
            })
            task.resume()
        } catch _ {
            print ("Some error :)")
        }
    }
    
    fileprivate func authenticateUser() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        if email.trimmedString() == "" || password.trimmedString() == "" {
            return
        }
        if isLogin {
            login(email: email, password: password)
        } else {
            register(email: email, password: password)
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
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        if token != "" {
            let dic:[String: String] = [
                "token": token
            ]
            getRequest(url: "/user", dic: dic)
        } else {
            print("No token")
        }
    }
    
//MARK: Helpers
    @objc func handleDismissTap(_ gesture: UITapGestureRecognizer) { //dismiss fields
        self.view.endEditing(false)
    }
    
    fileprivate func getRequest(url: String, dic: [String: Any]) {
        if (!JSONSerialization.isValidJSONObject(dic)) {
            print("is not a valid json object")
            return
        }
        let session = URLSession.shared
        let url = "http://3.17.150.127:8000" + url
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "token")
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            if let response = response {
                let nsHTTPResponse = response as! HTTPURLResponse
                let statusCode = nsHTTPResponse.statusCode
                print ("status code = \(statusCode)")
            }
            if let error = error {
                print ("\(error)")
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Message.self, from: data)
                    print(response.success)
                } catch {
                    print(error)
                }
//                do { //MARK: On /create, error is JSON not formatted. On /user error is dataCorrupted... Invalid value around character
//                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
//                    print ("jsonResponse: \(jsonResponse)")
//                } catch _ {
//                    print ("JSON not formatted")
//                }
            }
        })
        task.resume()
    }
    
///url = /user or /login or /create, method = "POST" or "GET", and dic is the data
    fileprivate func postRequest(url: String, dic: [String: Any]) {
        if (!JSONSerialization.isValidJSONObject(dic)) {
            print("is not a valid json object")
            return
        }
        let session = URLSession.shared
        let url = "http://3.17.150.127:8000" + url
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept") //idk if not needed
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print ("status code = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
//                        do {
//                            let response = try JSONDecoder().decode(Token.self, from: data)
//                        print(response.token)
//                            self.token = response.token
//                        } catch {
//                            print(error)
//                        }
                    do { //MARK: On /create, error is JSON not formatted. On /user error is dataCorrupted... Invalid value around character
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        print ("jsonResponse: \(jsonResponse)")
                    } catch _ {
                        print ("JSON not formatted")
                    }
                }
            })
            task.resume()
        } catch _ {
            print ("Some error :)")
        }
    }
}

//MARK: Extensions
