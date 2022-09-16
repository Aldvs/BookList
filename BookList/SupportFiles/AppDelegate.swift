//
//  AppDelegate.swift
//  BookList
//
//  Created by admin on 13.09.2022.
//

import UIKit
import KeychainSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let keychain = KeychainSwift(keyPrefix: "book_")
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if let isAuth = keychain.getBool("isAuth"), isAuth {
            window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        } else {
            window?.rootViewController = UINavigationController(rootViewController: StartViewController())
        }
        return true
    }

}

