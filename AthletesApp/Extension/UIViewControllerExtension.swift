//
//  UIViewControllerExtension.swift
//  AthletesApp
//
//  Created by Aitor on 24/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

var vSpinner : UIView?
 
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = spinnerView.center
        activityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
