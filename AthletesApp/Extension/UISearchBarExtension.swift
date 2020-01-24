//
//  UISearchBarExtension.swift
//  AthletesApp
//
//  Created by Aitor on 24/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

extension UISearchBar {
    func changeSearchBarColor(color : UIColor) {
        self.searchBarStyle = UISearchBar.Style.minimal
        for subView in self.subviews {
            for subSubView in subView.subviews {
                if subSubView.conforms(to: UITextInputTraits.self) {
                    let textField = subSubView as! UITextField
                    textField.backgroundColor = color
                    break
                }
            }
        }
    }
}
