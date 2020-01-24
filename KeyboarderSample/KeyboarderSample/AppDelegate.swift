//
//  AppDelegate.swift
//  KeyboarderSample
//
//  Created by Arash Goodarzi on 1/16/20.
//  Copyright © 2020 Arash Goodarzi. All rights reserved.
//

import UIKit
import Keyboarder

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Keyboarder.shared.isEnabled = true
        return true
    }



}

