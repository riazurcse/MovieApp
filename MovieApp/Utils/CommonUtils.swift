//
//  CommonUtils.swift
//  MovieApp
//
//  Created by Riajur Rahman on 23/2/21.
//

import Foundation
import UIKit

class CommonUtils {
    
    static func showPrompt(_ title: String, message: String, buttons: [String], destructiveButtonIndex: Int? = nil, cancelButtonIndex: Int? = nil, boldButtonIndex: Int? = nil, delegate: UIViewController?, completion: @escaping (_ clicked: Int) -> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for (index, title) in buttons.enumerated() {
            var actionStyle:UIAlertAction.Style = .default
            if index == destructiveButtonIndex {
                actionStyle = .destructive
            } else if index == cancelButtonIndex {
                actionStyle = .cancel
            }
            let action = UIAlertAction(title: title, style:actionStyle, handler: {(action : UIAlertAction!) -> Void in
                completion(index)
            })
            alertController.addAction(action)
            if index == boldButtonIndex {
                alertController.preferredAction = action
            }
        }
        
        if delegate != nil {
            delegate!.present(alertController, animated: true, completion: nil)
            
        } else {
            var rootViewController = getKeyWindow()?.rootViewController
            if let navigationController = rootViewController as? UINavigationController {
                rootViewController = navigationController.viewControllers.first
            }
            if let tabBarController = rootViewController as? UITabBarController {
                rootViewController = tabBarController.selectedViewController
            }
            if rootViewController != nil {
                rootViewController!.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    static func getKeyWindow() -> UIWindow? {
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first

        return window
    }
}
