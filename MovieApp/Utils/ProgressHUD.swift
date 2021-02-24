//
//  ProgressHUD.swift
//  MovieApp
//
//  Created by Riajur Rahman on 22/2/21.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class ProgressHUD {
    
    static let sharedInstance = ProgressHUD()
    var container = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
    var subContainer = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH / 2.2, height: SCREEN_WIDTH / 3.5))
    var textLabel = UILabel()
    var activityIndicatorView = UIActivityIndicatorView()
    var blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    init() {
        //Main Container
        container.backgroundColor = UIColor.clear
        
        //Sub Container
        subContainer.layer.cornerRadius = 5.0
        subContainer.layer.masksToBounds = true
        subContainer.backgroundColor = UIColor.clear
        
        //Activity Indicator
        activityIndicatorView.hidesWhenStopped = true
        
        //Text Label
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        textLabel.textColor = UIColor.darkGray
        
        //Blur Effect
        //always fill the view
        blurEffectView.frame = container.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func show() -> Void {
        
        container.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
            activityIndicatorView.style = .whiteLarge
        }
        activityIndicatorView.center = CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGHT / 2)
        activityIndicatorView.color = UIColor.white
        
        activityIndicatorView.startAnimating()
        container.addSubview(activityIndicatorView)
        if let window = CommonUtils.getKeyWindow() {
            window.addSubview(container)
        }
        container.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 1.0
        })
    }
    
    func showWithBlurView() {
        
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            container.backgroundColor = UIColor.clear
            container.addSubview(blurEffectView)
        } else {
            container.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        }
        
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
            activityIndicatorView.style = .whiteLarge
        }
        activityIndicatorView.center = CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGHT / 2)
        activityIndicatorView.color = UIColor.white

        activityIndicatorView.startAnimating()
        container.addSubview(activityIndicatorView)
        if let window = CommonUtils.getKeyWindow() {
            window.addSubview(container)
        }
        container.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 1.0
        })
    }
    
    func hide() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 0.0
        }) { finished in
            self.activityIndicatorView.stopAnimating()
            
            self.activityIndicatorView.removeFromSuperview()
            self.textLabel.removeFromSuperview()
            self.subContainer.removeFromSuperview()
            self.blurEffectView.removeFromSuperview()
            self.container.removeFromSuperview()
        }
    }
    
    func show(withTitle title: String?) {
        
        container.backgroundColor = UIColor.clear
        
        subContainer.backgroundColor = UIColor(named: "system_grouped_background_color")
        subContainer.center = CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGHT / 2)
        container.addSubview(subContainer)
        
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
            activityIndicatorView.style = .whiteLarge
        }
        activityIndicatorView.color = UIColor.black
        activityIndicatorView.frame = CGRect(x: 0, y: 10, width: subContainer.bounds.width, height: subContainer.bounds.height / 3.0)
        activityIndicatorView.center = CGPoint(x: activityIndicatorView.center.x, y: activityIndicatorView.center.y)
        subContainer.addSubview(activityIndicatorView)
        
        let height: CGFloat = subContainer.bounds.height - activityIndicatorView.bounds.height - 10.0
        textLabel.frame = CGRect(x: 5, y: 10 + activityIndicatorView.bounds.height, width: subContainer.bounds.width - 10.0, height: height - 5.0)
        textLabel.text = title
        subContainer.addSubview(textLabel)
        
        activityIndicatorView.startAnimating()
        if let window = CommonUtils.getKeyWindow() {
            window.addSubview(container)
        }
        container.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 1.0
        })
    }
    
    func showDarkBackgroundView(withTitle title: String?) {
        
        container.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        subContainer.backgroundColor = UIColor(named: "system_grouped_background_color")
        subContainer.center = CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGHT / 2)
        container.addSubview(subContainer)
        
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = UIActivityIndicatorView.Style.medium
        } else {
            // Fallback on earlier versions
            activityIndicatorView.style = .whiteLarge
        }
        activityIndicatorView.color = UIColor.black
        activityIndicatorView.frame = CGRect(x: 0, y: 10, width: subContainer.bounds.width, height: subContainer.bounds.height / 3.0)
        activityIndicatorView.center = CGPoint(x: activityIndicatorView.center.x, y: activityIndicatorView.center.y)
        subContainer.addSubview(activityIndicatorView)
        
        let height: CGFloat = subContainer.bounds.height - activityIndicatorView.bounds.height - 10.0
        textLabel.frame = CGRect(x: 5, y: 10 + activityIndicatorView.bounds.height, width: subContainer.bounds.width - 10.0, height: height - 5.0)
        textLabel.text = title
        subContainer.addSubview(textLabel)
        
        activityIndicatorView.startAnimating()
        if let window = CommonUtils.getKeyWindow() {
            window.addSubview(container)
        }
        container.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 1.0
        })
    }
    
    func showBlurView(withTitle title: String?) {
        
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            container.backgroundColor = UIColor.clear
            container.addSubview(blurEffectView)
        } else {
            container.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        }
        
        subContainer.backgroundColor = UIColor(named: "system_grouped_background_color")
        activityIndicatorView.color = UIColor.black
        subContainer.center = CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGHT / 2)
        container.addSubview(subContainer)
        
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = UIActivityIndicatorView.Style.medium
        } else {
            // Fallback on earlier versions
            activityIndicatorView.style = .whiteLarge
        }
        activityIndicatorView.frame = CGRect(x: 0, y: 10, width: subContainer.bounds.width, height: subContainer.bounds.height / 3.0)
        activityIndicatorView.center = CGPoint(x: activityIndicatorView.center.x, y: activityIndicatorView.center.y)
        subContainer.addSubview(activityIndicatorView)
        
        let height: CGFloat = subContainer.bounds.height - activityIndicatorView.bounds.height - 10.0
        textLabel.frame = CGRect(x: 5, y: 10 + activityIndicatorView.bounds.height, width: subContainer.bounds.width - 10.0, height: height - 5.0)
        textLabel.text = title
        subContainer.addSubview(textLabel)
        
        activityIndicatorView.startAnimating()
        if let window = CommonUtils.getKeyWindow() {
            window.addSubview(container)
        }
        container.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 1.0
        })
    }
    
    func updateProgressTitle(_ title: String?) {
        textLabel.text = title
    }
}
