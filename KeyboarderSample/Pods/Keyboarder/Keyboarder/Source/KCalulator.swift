//
//  DistanceCalulator.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/6/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit

protocol KCalcultingLogic: class {
    func shouldScrollUIScrollView(activeTextInput: KTextInput, keyboardHeight: CGFloat) -> Bool
    func getAddingYtoMakeVisible(for activeTextInput: KTextInput?, with keyboardHeight: CGFloat) -> CGFloat
}

class KCalcultor: KCalcultingLogic {
    
    weak var viewController: KeyboarderDelegate?
    
    private var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    func shouldScrollUIScrollView(activeTextInput: KTextInput, keyboardHeight: CGFloat) -> Bool {
        
        guard let mainView = viewController?.view else {
            return false
        }
        var mainFrame: CGRect =  mainView.frame
        mainFrame.size.height -= keyboardHeight
        let mainFrameContainsActiveTextInput = mainFrame.contains(activeTextInput.getFrame.origin)
        return !mainFrameContainsActiveTextInput
    }
    
    func getAddingYtoMakeVisible(for activeTextInput: KTextInput?, with keyboardHeight: CGFloat) -> CGFloat {
        
        guard let viewController = viewController, let activeTextInput = activeTextInput else {
            return 0.0
        }
        let navBarHeight = viewController.navigationController?.navigationBar.frame.height ?? 0.0
        
        let screenHeight = UIScreen.main.bounds.height
        let viewCurrentY = viewController.view.frame.origin.y
        let viewHeight = viewController.view.frame.height
        let minAllowedViewY = screenHeight - viewHeight
        let activeTextInputY = activeTextInput.getFrame.origin.y
        let activeTextInputHeight = activeTextInput.getFrame.height
        let extraPadding: CGFloat = 5
        let visualAreaMinY = -viewCurrentY + statusBarHeight + navBarHeight + extraPadding
        let visualAreaMaxY = -viewCurrentY + screenHeight - keyboardHeight - activeTextInputHeight + extraPadding
        
        if activeTextInputY <= visualAreaMinY {
            let y = viewCurrentY + (visualAreaMinY - activeTextInputY)
            let addingY = y > 0 ? 0 : y
            return addingY
        }
        
        if activeTextInputY > visualAreaMinY {
            let y = viewCurrentY - ( activeTextInputY - visualAreaMaxY)
            let addingY = y < minAllowedViewY ? minAllowedViewY : y
            return addingY
        }
        
        return 0.0
    }
    
}

