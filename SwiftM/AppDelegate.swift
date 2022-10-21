//
//  AppDelegate.swift
//  SwiftM
//
//  Created by mazb on 2022/10/19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // 是否横屏
    var isLandscape = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame:UIScreen.main.bounds)
        
        let rootVC = ViewController()
        let nav = UINavigationController(rootViewController: rootVC)
        window.rootViewController = nav
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}



// MARK: - 自定义 log
func MLog<T>(message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
    
    let fileName = (file as NSString).lastPathComponent
//        print("m--\(fileName):[\(funcName)](\(lineNum))")
    print("m--\(fileName):(\(lineNum))--\(message)")
    
    #endif
}

