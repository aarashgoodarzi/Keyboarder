//
//  Toolbar.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/6/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit

class KToolbar: UIToolbar {
    
    
    weak var navigator: KNavigator?
    var doneBtnClosure: ActionClosure?
    var doneBtnTitle: String?
    weak var textInput: KTextInput?
    private var toolbarColor: UIColor {
        guard let keyboardAppearance = textInput?.keyboardAppearance else {
            return .black
        }
        
        switch keyboardAppearance {
        case .default:
            return .white
        case .dark:
            return .black
        default:
            return .gray
        }
    }
    
    //*
    private var barButtonColor: UIColor {
        guard let keyboardAppearance = textInput?.keyboardAppearance else {
            return .black
        }
        
        switch keyboardAppearance {
        case .default:
            return .black
        case .dark:
            return .white
        default:
            return .gray
        }
    }
    
    //**
    private var toolbarItems: [KBarButton] {
        
        let doneButton = KBarButton()
        doneButton.set(title: "Done", color: barButtonColor, image: nil) { [weak self] in
            guard let self = self else {
                return
            }
            self.textInput?.endEditing()
        }
        
        let spaceButton = KBarButton(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let nextButton = KBarButton()
        nextButton.set(title: "▶︎", color: barButtonColor, image: nil) { [weak self] in
            guard let self = self else {
                return
            }
            self.navigator?.next()
        }
        
        let previousButton = KBarButton()
        nextButton.set(title: "◀︎", color: barButtonColor, image: nil) { [weak self] in
            guard let self = self else {
                return
            }
            self.navigator?.previous()
        }
        
        return [doneButton,spaceButton,nextButton,previousButton]

    }

    //**
    init(textInput: KTextInput, navigator: KNavigator) {
        super.init(frame: .zero)
        self.navigator = navigator
        self.textInput = textInput
        self.barStyle = .default
        self.isTranslucent = true
        self.tintColor = toolbarColor
        self.setItems(toolbarItems, animated: false)
        self.isUserInteractionEnabled = true
        self.sizeToFit()
        textInput.setInputAccessoryView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
