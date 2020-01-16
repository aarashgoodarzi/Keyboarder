//
//  SwizzledMethods.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/7/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit

//MARK: - swizzle
extension NSObject {
    
    static func swizzle(_ firstMethod: Selector, with secondMethod: Selector) {
        
        let _originalMethod = class_getInstanceMethod(self, firstMethod)
        let _swizzledMethod = class_getInstanceMethod(self, secondMethod)
        
        guard let swizzledMethod = _swizzledMethod, let originalMethod = _originalMethod else {
            return
        }
        let didAddMethod = class_addMethod(self, firstMethod, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        guard didAddMethod else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
            return
        }
        
        class_replaceMethod(self, secondMethod, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
     
    }
}

//MARK: - swizzleViewLifecycle
extension UIViewController {
    static func swizzleViewLifecycle() {
        swizzleViewDidLaod()
        swizzleViewDidDisappear()
    }
    
    static func deswizzleViewLifecycle() {
        deswizzleViewDidLaod()
        deswizzleViewDidDisappear()
    }
}

//MARK: - viewDidLaod
extension UIViewController {
    
    static func swizzleViewDidLaod() {
        let originalSelector = #selector(UIViewController.viewDidLoad)
        let swizzledSelector = #selector(UIViewController.khViewDidLoad)
        swizzle(originalSelector, with: swizzledSelector)
    }
    
    static func deswizzleViewDidLaod() {
        let originalSelector = #selector(UIViewController.viewDidLoad)
        let swizzledSelector = #selector(UIViewController.khViewDidLoad)
        swizzle(swizzledSelector, with: originalSelector)
    }
    
    @objc func khViewDidLoad() {
        self.khViewDidLoad()
        Keyboarder.shared.presentingVcDidLoad(viewController: self)
    }
}


//MARK: - ViewDidApear
extension UIViewController {
   
    static func swizzleViewDidDisappear() {
        let originalSelector = #selector(UIViewController.viewDidDisappear(_:))
        let swizzledSelector = #selector(UIViewController.khViewDidDisappear)
        swizzle(originalSelector, with: swizzledSelector)
    }
    
    static func deswizzleViewDidDisappear() {
        let originalSelector = #selector(UIViewController.viewDidDisappear(_:))
        let swizzledSelector = #selector(UIViewController.khViewDidDisappear)
        swizzle(swizzledSelector, with: originalSelector)
    }
    
    @objc func khViewDidDisappear() {
        self.khViewDidDisappear()
        Keyboarder.shared.presentingVcDidDispappear(viewController: self)
    }
}
