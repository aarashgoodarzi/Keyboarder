//
//  File.swift
//  KeyboardHandler
//
//  Created by Arash Goodarzi on 1/7/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit

class KBarButton: UIBarButtonItem {
    
    var buttonAction: ActionClosure?
    private var button = UIButton(type: .custom)
    
    //**
    func set(title: String?, color: UIColor, image: UIImage?, action: @escaping ActionClosure) {
        button.frame = CGRect(origin: .zero, size: CGSize(width: 36, height: 36))
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(actionFunc), for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
        button.setImage(image, for: .normal)
        buttonAction = action
        self.customView = button
        self.tintColor = color
    }
    
    //**
    @objc
    func actionFunc() {
        buttonAction?()
    }
}
