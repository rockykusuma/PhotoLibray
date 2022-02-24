//
//  UISearch+Extensions.swift
//  PhotoLibrary
//
//  Created by Rakesh Kusuma on 24/02/22.
//

import UIKit

extension UISearchBar {
    @IBInspectable var doneAccessory: Bool {
        get {
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone {
                addDoneButtonOnKeyboard()
            } else {
                removeDoneButtonOnKeyboard()
            }
        }
    }
    
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    private func removeDoneButtonOnKeyboard() {
        self.inputAccessoryView = nil
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
