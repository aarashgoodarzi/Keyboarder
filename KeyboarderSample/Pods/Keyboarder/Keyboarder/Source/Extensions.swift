//
//  Extensions.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/5/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit


//***
extension NSNotification {
    var keyboardHeight: CGFloat {
        let info = self.userInfo
        let kbRect: CGRect = (info?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let kbSize: CGSize = kbRect.size
        return kbSize.height
    }
}

//***
extension Optional {
    var isNil: Bool {
        return self == nil
    }
    
    var isNotNil: Bool {
        return self != nil
    }
}

//***
extension Optional where Wrapped == String {
    
    var stringValue: String {
        return self ?? ""
    }
    
    var isBlank: Bool {
        return self.stringValue.isEmpty
    }
}

//***


