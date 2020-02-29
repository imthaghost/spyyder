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

//MARK: Network Calls
func postRequest(url: String, userDic: [String: Any], completion: @escaping(_ error: String?, _ user: User?) -> Void) { //user for Registering user
    if (!JSONSerialization.isValidJSONObject(userDic)) {
        completion("Invalid email and password data", nil)
    }
    let session = URLSession.shared
    let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: userDic, options: .prettyPrinted)
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
//                do {
//                    let response = try JSONDecoder().decode(Token.self, from: data)
//                    print(response.token)
//                } catch { print(error) }
                do { //MARK: On /create, error is JSON not formatted. On /user error is dataCorrupted... Invalid value around character
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                    print ("jsonResponse: \(jsonResponse)")
                    guard let response = jsonResponse as? [String: Any] else { completion("Error converting json received", nil); return }
                    if let errorMessage = response[kMESSAGE] as? String { //if we get a message response, it means there is an error
                        print("Error = \(errorMessage)")
                        completion(errorMessage, nil)
                    }
                    if let _ = response["success"] { //if we have a success key then create user
                        let user = User(_dictionary: userDic)
                        completion(nil, user)
                    }
                    if let token = response[kTOKEN] {
                        print("Token = ", token)
                    } else {
                        print("No token found")
                    }
                    //Should not reach here, display unknown error
                    completion("Unknown response error", nil)
                } catch _ {
                    completion("JSON not formatted", nil)
                }
            }
        })
        task.resume()
    } catch _ {
        print ("Some error :)")
    }
}

func login(email: String, password: String, completion: @escaping(_ error: String?, _ user: User?) -> Void) {
    var userDic:[String: String] = [
        kEMAIL: email,
        "password": password,
    ]
    if (!JSONSerialization.isValidJSONObject(userDic)) {
        completion("Invalid email and password data", nil)
    }
    let session = URLSession.shared
    let url = "http://3.17.150.127:8000/login"
    let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: userDic, options: .prettyPrinted)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            if let response = response {
                let nsHTTPResponse = response as! HTTPURLResponse
                let statusCode = nsHTTPResponse.statusCode
                print ("status code = \(statusCode)")
            }
            if let error = error {
                completion(error.localizedDescription, nil)
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Token.self, from: data) //MARK: Handle Error here in case request does not return any Token
                    userDic[kUSERID] = UUID().uuidString
                    userDic[kTOKEN] = response.token
                    print("Token \(response.token)")
                    getRequestUser(userDic: userDic) { (error, user) in
                        if let error = error {
                            completion(error, nil)
                        }
                        completion(nil, user!)
                    }
                } catch {
                    completion(error.localizedDescription, nil)
                }
//                do {
//                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
//                    print ("jsonResponse: \(jsonResponse)")
//                } catch _ { print ("JSON not formatted") }
            }
        })
        task.resume()
    } catch _ {
        completion("Login request error", nil)
    }
}

///Takes a token and performs a GET request from the API and returns a user from the database if no error
func getRequestUser(userDic: [String: Any], completion: @escaping(_ error: String?, _ user: User?) -> Void) {
    guard let token = userDic[kTOKEN] as? String else { completion("No token", nil); return }
    let session = URLSession.shared
    let url = "\(kAPIURL)/user"
    let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
    request.httpMethod = "GET"
    request.setValue(token, forHTTPHeaderField: "token") //set token to the header
    let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
        if let response = response {
            let nsHTTPResponse = response as! HTTPURLResponse
            let statusCode = nsHTTPResponse.statusCode
            print ("status code = \(statusCode)")
        }
        if let error = error {
            completion(error.localizedDescription, nil)
        }
        if let data = data {
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                print ("jsonResponse: \(jsonResponse)")
                guard let response = jsonResponse as? [String: Any] else { completion("Error converting json received", nil); return }
                if let errorMessage = response[kMESSAGE] as? String { //if we get a message response, it means there is an error
                    print("Error = \(errorMessage)")
                    completion(errorMessage, nil)
                }
                if let _ = response["success"] { //if we have a success key then create user
                    let user = User(_dictionary: userDic)
                    completion(nil, user)
                    return
                }
                if let token = response[kTOKEN] {
                    print("Token = ", token)
                } else {
                    print("No token found")
                }
                //Should not reach here, display unknown error
                completion("Unknown response error", nil)
//                let response = try JSONDecoder().decode(Message.self, from: data)
//                print(response.success)
//                let user = User(_dictionary: userDic)
//                completion(nil, user)
            } catch {
                completion(error.localizedDescription, nil)
            }
        }
    })
    task.resume()
}
