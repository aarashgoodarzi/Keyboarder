//
//  InputViewsNavigator.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/5/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit


protocol KNavigationLogic {
    func next()
    func previous()
    func addIngnoredViews(views: [UIView])
    func addIngnoredView(view: UIView)
    func reset()
    func set(isKHEnabled: Bool, viewController: UIViewController?)
}

class KNavigator: KNavigationLogic {
    
    private var ignoredViews: [UIView] = []
    private var keyboardHandledViews: [UIView] = []
    var currnetViewIndex: Int = 0 {
        didSet {
            makeFirstResponder()
        }
    }
    
    //MARK: - Methods
    func addIngnoredViews(views: [UIView]) {
        let views = views.map { $0 }
        ignoredViews.append(contentsOf: views)
    }

    func addIngnoredView(view: UIView) {
        ignoredViews.append(view)
    }
    
    //**
    func reset() {
        ignoredViews.removeAll()
        keyboardHandledViews.removeAll()
    }

    //**
    func set(isKHEnabled: Bool, viewController: UIViewController?) {
        calculateKeyboardHandledViews(isKHEnabled: isKHEnabled, viewController: viewController)
    }
    
    //**
    private func calculateKeyboardHandledViews(isKHEnabled: Bool, viewController: UIViewController?) {
        
        guard isKHEnabled else {
            return
        }
        
        guard let viewContrller = viewController else {
            print(" --- KeyboardHandler: you may set the deleagte of keyboard handler ---")
            return
        }
        
        keyboardHandledViews = viewContrller.view.subviews.filter { (view) -> Bool in
            let viewIsIgnored = ignoredViews.contains(view)
            let viewIsUITextInput = view is UITextInput
            return !viewIsIgnored && viewIsUITextInput
        }
    }
    
    //**
    func next() {
        let keyboardHandledViewsMaxIndex = keyboardHandledViews.count - 1
        guard currnetViewIndex >= keyboardHandledViewsMaxIndex else {
            return
        }
        
        currnetViewIndex += 1
    }
    
    //**
    func previous() {
        
        guard currnetViewIndex <= 0 else {
            return
        }
        currnetViewIndex -= 1
    }
    
    //**
    func makeFirstResponder() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.keyboardHandledViews[self.currnetViewIndex].becomeFirstResponder()
        }
    }

}
