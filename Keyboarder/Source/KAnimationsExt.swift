//
//  Animation.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/6/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit


//***
extension KeyboarderDelegate {
    func animateView(toUp: Bool, keyboardHeight: CGFloat = 0.0) {
    
    let assigningY = toUp ? self.view.frame.origin.y - keyboardHeight : 0
    UIView.animate(withDuration: 0.6, animations: { [weak self] in
      guard let self = self else {
        return
      }
      self.view.frame.origin.y = assigningY
      self.view.layoutIfNeeded()
    })
  }
}

//***
extension KeyboarderDelegate {
    
    func animateView(addingY: CGFloat) {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
          guard let self = self else {
            return
          }
          self.view.frame.origin.y = addingY
          self.view.layoutIfNeeded()
        })

    }
    
    func resetViewOrigin() {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
          guard let self = self else {
            return
          }
          self.view.frame.origin.y = 0
          self.view.layoutIfNeeded()
        })
    }
}

