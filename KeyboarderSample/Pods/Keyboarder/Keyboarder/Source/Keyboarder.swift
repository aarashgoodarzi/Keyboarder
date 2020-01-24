//
//  KeyboardHandler.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/5/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit

open class Keyboarder: KeyboarderProtocol {
    
    
    //MARK: - Vars
    public static var shared = Keyboarder()
    private var _isEnabled: Atomic<Bool> = Atomic(false)
    
    open var isEnabled: Bool {
        get {
            return self._isEnabled.value
        }
        
        set {
            _isEnabled.didSetValue = {
                self.initilize()
                self.setup()
            }
            
            _isEnabled.value = newValue
            
        }
    }
    
    private var _isToolbarEnabled: Atomic<Bool> = Atomic(false) {
        didSet {
            if !_isToolbarEnabled.value {
                self.toolBar = nil
            }
        }
    }
    
    open var isToolbarEnabled: Bool  {
        get {
            return self._isToolbarEnabled.value
        }
        
        set {
            self._isToolbarEnabled.value = newValue
        }
    }
    
    private var _activeTextInput: Atomic<KTextInput>? {
        didSet {
            setToolbar(for: activeTextInput)
        }
    }
    
    var activeTextInput: KTextInput? {
        get {
            return self._activeTextInput?.value
        }
        
        set {
            guard let newValue = newValue else {
                self._activeTextInput = nil
                return
            }
            self._activeTextInput?.value = newValue
        }
    }
    
    
    weak var delegate: KeyboarderDelegate?
    var willShowClosure: KeyboardClosure?
    var didShowClosure: KeyboardClosure?
    var willHideClosure: KeyboardClosure?
    var didHideClosure: KeyboardClosure?
    private var toolBar: KToolbar?
    var scroller: KScrollingLogic?
    
    private init() {
        
    }
    
    private func initilize() {
        let calculator = KCalcultor()
        let scroller = KScroller(viewController: delegate, calculator: calculator)
        calculator.viewController = delegate
        self.scroller = scroller
    }
    
    private func setToolbar(for textInput: KTextInput?) {
        
        guard let textInput = textInput else {
            self.isToolbarEnabled = false
            return
        }
        let navigator = KNavigator()
        navigator.set(isKHEnabled: isEnabled, viewController: delegate)
        let kToolbar = KToolbar(textInput: textInput, navigator: navigator)
        self.toolBar = kToolbar
    }
    
    //MARK: - Methods
    open func addIngnoredViews(views: [UIView]) {
        let views = views.map { $0 }
        toolBar?.navigator?.addIngnoredViews(views: views)
    }
    
    open func addIngnoredView(view: UIView) {
        toolBar?.navigator?.addIngnoredView(view: view)
    }
    
    //adding actin means user do not want auto scroll so just this section will be enabled
    open func willShow(_ compeltion: @escaping (_ keyboardHieght: CGFloat) -> Void) {
        willShowClosure = compeltion
        UIViewController.deswizzleViewLifecycle()
    }
    
    open func willHide(_ compeltion: @escaping (_ keyboardHieght: CGFloat) -> Void) {
        willHideClosure = compeltion
        UIViewController.deswizzleViewLifecycle()
    }
    
    open func didShow(_ compeltion: @escaping (_ keyboardHieght: CGFloat) -> Void) {
        didShowClosure = compeltion
        UIViewController.deswizzleViewLifecycle()
    }
    
    open func didHide(_ compeltion: @escaping (_ keyboardHieght: CGFloat) -> Void) {
        didHideClosure = compeltion
        UIViewController.deswizzleViewLifecycle()
    }
    open func toolbarDoneBtnAction(_ compeltion: @escaping () -> Void) {
        toolBar?.doneBtnClosure = compeltion
    }
    
    //**
    private func setup() {
        guard isEnabled else {
            UIViewController.deswizzleViewLifecycle()
            removeAllObeservers()
            return
        }
        UIViewController.swizzleViewLifecycle()
        addKeyboardObservers()
    }
    
    //**
    func presentingVcDidLoad(viewController: UIViewController) {
        delegate = viewController as? KeyboarderDelegate
    }
    
    //**
    func presentingVcDidDispappear(viewController: UIViewController) {
        toolBar = nil
        scroller?.resetScroll()
    }
    
    //**
    private func addKeyboardObservers() {
        
        guard isEnabled else {
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    //**
    private func removeAllObeservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
}

//----------------------------


