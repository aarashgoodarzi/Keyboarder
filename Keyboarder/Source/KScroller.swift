//
//  Scroller.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/6/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit

protocol KScrollingLogic: class {
    var viewController: KeyboarderDelegate? { get }
    func scroll(to activeTextInput: KTextInput?, keyboardHeight: CGFloat)
    func resetScroll()
}


class KScroller: KScrollingLogic {
    
    var viewController: KeyboarderDelegate?
    var scrollView: UIScrollView?
    let calculator: KCalcultingLogic
    var activeTextInput: KTextInput?
    var keyboardHeight: CGFloat?
    
    init(viewController: KeyboarderDelegate?, calculator: KCalcultingLogic) {
        self.calculator = calculator
        self.viewController = viewController
        setScrollView(viewController: viewController)
    }
    
    private func setScrollView(viewController: KeyboarderDelegate?) {
        guard let views = viewController?.view.subviews else {
            return
        }
        
        for view in views where view is UIScrollView {
            self.scrollView = view as? UIScrollView
            break
        }
        
    }
    
    //MARK: - Scroll
    func scroll(to activeTextInput: KTextInput?, keyboardHeight: CGFloat) {
        guard let activeTextInput = activeTextInput else {
            return
        }
        self.activeTextInput = activeTextInput
        self.keyboardHeight = keyboardHeight
        
        //if scroll view is container
        if let scrollView = scrollView {
            scrollUIScrollView(scrollView: scrollView)
            return
        }
      
        //else scroll main view intead
        scrollMainView()
    }
    
    //**
    func resetScroll() {
        if scrollView.isNotNil {
            resetScrollViewInsets()
            return
        }
        scrollView.isNil ? resetMainViewOrigin() : resetScrollViewInsets()
         
    }
    //scroll view to make text input visible
    private func scrollMainView() {
        guard let keyboardHeight = keyboardHeight, let activeTextInput = activeTextInput  else {
            return
        }
        let addingY = calculator.getAddingYtoMakeVisible(for: activeTextInput, with: keyboardHeight)
        viewController?.animateView(addingY: addingY)
    }
    
    //scroll ScrollView to make text input visible
    private func scrollUIScrollView(scrollView: UIScrollView) {
        
        guard let keyboardHeight = keyboardHeight, let activeTextInput = activeTextInput else {
            return
        }
        initialInsets(scrollView: scrollView)
        let shouldScrollUIScrollView = calculator.shouldScrollUIScrollView(activeTextInput: activeTextInput, keyboardHeight: keyboardHeight)
        if shouldScrollUIScrollView {
            scrollView.scrollRectToVisible(activeTextInput.getFrame, animated: true)
            resetScrollViewInsets()
        }
    }
    
    //**
    private func initialInsets(scrollView: UIScrollView) {
        guard let keyboardHeight = keyboardHeight else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    //**
    private func resetScrollViewInsets() {
        let contentInsets: UIEdgeInsets = .zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    private func resetMainViewOrigin() {
        viewController?.resetViewOrigin()
    }
}


