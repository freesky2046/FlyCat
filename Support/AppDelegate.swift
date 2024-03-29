//
//  AppDelegate.swift
//  FlyCat
//
//  Created by 周明 on 2023/4/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(tvOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        window = UIWindow();
        let vc = FCFirstViewController.build()
        let nav = UINavigationController(rootViewController: vc!)
        nav.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = nav
        window?.makeKeyAndVisible();
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

