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
    static var shared = Keyboarder()
    private var _isEnabled: Atomic<Bool> = Atomic(false)
    private var _isToolbarEnabled: Atomic<Bool> = Atomic(true)
    public static var isEnabled: Bool {
        get {
            return shared._isEnabled.value
        }
    }
    
    public static var isToolbarEnabled: Bool  {
        get {
            return shared._isToolbarEnabled.value
        }
    }
    
    private var _activeTextInput: Atomic<KTextInput>? {
        didSet {
            setToolbar(for: activeTextInput)
        }
    }
    
    var activeTextInput: KTextInput? {
        get {
            return _activeTextInput?.value
        }
        
        set {
            guard let newValue = newValue else {
                _activeTextInput = nil
                return
            }
            _activeTextInput?.value = newValue
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
    
    //MARK: - Methods
    private func initilize() {
        let calculator = KCalcultor()
        let scroller = KScroller(viewController: delegate, calculator: calculator)
        calculator.viewController = delegate
        self.scroller = scroller
    }
    
    public static func enable() {
        shared._isEnabled.didSetValue = {
            shared.initilize()
            shared.setup()
        }
        
        shared._isEnabled.value = true
    }
    
    public static func disable() {
        shared._isEnabled.value = false
        
    }
    
    public static func enableToolbar() {
        shared._isToolbarEnabled.value = true
    }
    
    public static func disableToolbar() {
        shared._isToolbarEnabled.didSetValue = {
            if !shared._isToolbarEnabled.value {
                shared.toolBar = nil
            }
        }
        shared._isToolbarEnabled.value = false
    }
    
    private func setToolbar(for textInput: KTextInput?) {
        
        guard let textInput = textInput else {
            self._isToolbarEnabled.value = false
            return
        }
        let navigator = KNavigator()
        navigator.set(isKHEnabled: _isEnabled.value, viewController: delegate)
        let kToolbar = KToolbar(textInput: textInput, navigator: navigator)
        self.toolBar = kToolbar
    }
    
    
    public static func addIngnoredViews(views: [UIView]) {
        let views = views.map { $0 }
        shared.toolBar?.navigator?.addIngnoredViews(views: views)
    }
    
    public static func addIngnoredView(view: UIView) {
        shared.toolBar?.navigator?.addIngnoredView(view: view)
    }
    
    //adding actin means user do not want auto scroll so just this section will be enabled
    public static func willShow(_ compeltion: @escaping (_ keyboardHieght: CGFloat) -> Void) {
        shared.willShowClosure = compeltion
        UIViewController.deswizzleViewLifecycle()
    }
    
    public static func willHide(_ compeltion: @escaping (_ keyboardHieght: CGFloat) -> Void) {
        shared.willHideClosure = compeltion
        UIViewController.deswizzleViewLifecycle()
    }
    
    public static func didShow(_ compeltion: @escaping (_ keyboardHieght: CGFloat) -> Void) {
        shared.didShowClosure = compeltion
        UIViewController.deswizzleViewLifecycle()
    }
    
    public static func didHide(_ compeltion: @escaping (_ keyboardHieght: CGFloat) -> Void) {
        shared.didHideClosure = compeltion
        UIViewController.deswizzleViewLifecycle()
    }
    public static func toolbarDoneBtnAction(_ compeltion: @escaping () -> Void) {
        shared.toolBar?.doneBtnClosure = compeltion
    }
    
    //**
    private func setup() {
        guard _isEnabled.value else {
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
        
        guard _isEnabled.value else {
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


