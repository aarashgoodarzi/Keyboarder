//
//  Protocol.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/5/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit

//MARK: - Delegates

protocol KeyboardHandlingLogic: class {
    func keyboardWillShow(_ notification: NSNotification)
    func keyboardDidShow(_ notification: NSNotification)
    func keyboardWillHide(_ notification: NSNotification)
    func keyboardDidHide(_ notification: NSNotification)
}

public protocol KeyboarderDelegate: UIViewController {
    
}

protocol KeyboarderProtocol: class {
    
    var delegate: KeyboarderDelegate? { get }
}


extension Keyboarder: KeyboardHandlingLogic {
    @objc public func keyboardWillShow(_ notification: NSNotification) {
        willShowClosure?(notification.keyboardHeight)
    }
    
    @objc public func keyboardDidShow(_ notification: NSNotification) {
        didShowClosure?(notification.keyboardHeight)
        scroller?.scroll(to: activeTextInput, keyboardHeight: notification.keyboardHeight)
    }
    
    @objc public func keyboardWillHide(_ notification: NSNotification) {
        willHideClosure?(notification.keyboardHeight)
        scroller?.resetScroll()
    }
    
    @objc public func keyboardDidHide(_ notification: NSNotification) {
        didShowClosure?(notification.keyboardHeight)
    }
    
}
