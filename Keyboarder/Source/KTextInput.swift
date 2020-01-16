//
//  KHTextInput.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/6/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit

protocol KTextInput: class, UITextInput {
    
    //var getSuperview: UIView? { get }
    var getFrame: CGRect { get }
    func setInputAccessoryView(_ view: UIView)
    func endEditing()
    func didBeginEditing()
}

//MARK: - KHTextFiled
class KHTextFiled: UITextField, KTextInput, UITextFieldDelegate {
    
//    var getSuperview: UIView? {
//        return self.superview
//    }
    
    var getFrame: CGRect {
        return self.frame
    }
    
    func endEditing() {
        self.resignFirstResponder()
    }
    
    func setInputAccessoryView(_ view: UIView) {
        self.inputAccessoryView = view
    }
    
    func didBeginEditing() {
        Keyboarder.shared.activeTextInput = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didBeginEditing()
    }
}

//MARK: - KHTextView
class KHTextView: UITextView, KTextInput, UITextViewDelegate {
    
//    var getSuperview: UIView? {
//        return self.superview
//    }
    
    var getFrame: CGRect {
        return self.frame
    }
    
    var getOrigin: CGPoint {
        return self.frame.origin
    }
    
    func endEditing() {
        self.resignFirstResponder()
    }
    
    func setInputAccessoryView(_ view: UIView) {
        self.inputAccessoryView = view
    }
    
    func didBeginEditing() {
        Keyboarder.shared.activeTextInput = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        didBeginEditing()
    }
}
