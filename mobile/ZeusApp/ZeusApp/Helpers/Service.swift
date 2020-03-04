//
//  Service.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class Service {
    
    func popBack(on: UIViewController, nb: Int) { //method that pops View controller to a certain amount nb
        if let viewControllers: [UIViewController] = on.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                on.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    //presentAlert
    static func presentAlert(on: UIViewController, title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        on.present(alertVC, animated: true, completion: nil)
    }
    
    static func alertWithActions(on: UIViewController, actions: [UIAlertAction], title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertVC.addAction(action)
        }
        on.present(alertVC, animated: true, completion: nil)
    }
    
///Presents ViewControllers with animation from right to left or vice versa
    static func presentVCWithAnimation(fromVC: UIViewController, toVC: UIViewController, fromRight: Bool = true) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = fromRight ? .fromRight : .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        fromVC.view.window!.layer.add(transition, forKey: kCATransition) //apply its custom transition to the VC
        fromVC.present(toVC, animated: false, completion: nil)
    }
    
    static func presentNavWithAnimation(fromVC: UINavigationController, toVC: UINavigationController, fromRight: Bool = true) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = fromRight ? .fromRight : .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        fromVC.view.window!.layer.add(transition, forKey: kCATransition) //apply its custom transition to the VC
        fromVC.present(toVC, animated: false, completion: nil)
    }
    
    //    static func toMenuController(on: UIViewController) {
    //        goToController(on: on, withIdentifier: kMENUCONTROLLER)
    //    }
    //    static func toChatController(on: UIViewController) {
    //        goToController(on: on, withIdentifier: kCHATCONTROLLER)
    //    }
    //    static func toLoginController(on: UIViewController) {
    //        goToController(on: on, withIdentifier: kLOGINCONTROLLER)
    //    }
    //    static func toAnimationController(on: UIViewController) {
    //        goToController(on: on, withIdentifier: kANIMATIONCONTROLLER)
    //    }
    
    //    static func goToController(on: UIViewController, withIdentifier identifier: String) {
    //        let vc: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    //        on.present(vc, animated: true, completion: nil)
    //    }
    
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
    static func isValidEmail(email: String) -> Bool {
        let reg = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|"
        let test = NSPredicate(format: "SELF MATCHES %@", reg)
        let result = test.evaluate(with: email)
        
        return result
    }
    
    //dateFormatter()
    private let dateFormat = "yyyyMMddHHmmss" //RE ep.12 3mins made it private so it will remain constant and wont be changed at all outside of this file
    static func dateFormatter() -> DateFormatter { //RE ep.12 1min DateFormatter = A formatter that converts between dates and their textual representations.
        let dateFormatter = DateFormatter() //RE ep.12 2mins
        dateFormatter.dateFormat = Service().dateFormat //RE ep.12 3mins
        return dateFormatter //RE ep.12 4mins
    }
}

//        func goToNextController(vc: UIViewController, user: User) { //this method decides if user will be put to finish registrationVC or back to the app
//            if user.username == "" || user.imageUrl == "" {
//                let nav = vc.navigationController //grab an instance of the current navigationController
//                DispatchQueue.main.async { //make sure all UI updates are on the main thread.
//                    nav?.view.layer.add(CATransition().segueFromRight(), forKey: nil)
//                    let vc:FinishRegistrationVC = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: kFINISHREGISTRATIONVC) as! FinishRegistrationVC //this must be downcast to utilize it
//                    vc.user = user
//                    nav?.pushViewController(vc, animated: false)
//                }
//            } else { //if user has name and imageUrl then continue
//                vc.dismiss(animated: true, completion: nil)
//            }
//        }

