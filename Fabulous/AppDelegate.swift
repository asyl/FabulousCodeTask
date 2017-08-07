//
//  AppDelegate.swift
//  Fabulous
//
//  Created by Asyl Isakov on 2017/08/06.
//  Copyright © 2017年 asyl. All rights reserved.
//

import UIKit
import QuartzCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    self.configureAppereance()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    window?.makeKeyAndVisible()
    let fabulousController = FabulousController()
    let navigationController = UINavigationController(rootViewController: fabulousController)
    
    window?.rootViewController = navigationController
    return true
  }
  
  func configureAppereance() {
    UINavigationBar.appearance().barTintColor = UIColor.fabulousCyan
    UINavigationBar.appearance().barStyle = .black
    UINavigationBar.appearance().tintColor = UIColor.white
  }

}

