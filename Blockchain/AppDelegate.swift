//
//  AppDelegate.swift
//  Blockchain
//
//  Created by Boni on 2022/8/9.
//

import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
