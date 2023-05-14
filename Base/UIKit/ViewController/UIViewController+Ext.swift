//
//  UIViewController+Ext.swift
//  BilibiliLive
//
//  Created by yicheng on 2022/8/20.
//

import UIKit
extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presented = presentedViewController {
            return presented.topMostViewController()
        }

        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }

        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }

        return self
    }

    static func topMostViewController() -> UIViewController {
        return AppDelegate.shared.window!.rootViewController!.topMostViewController()
    }
    
    static func showHUD() {
        hideHUD()
        let activityView:UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: FCConstant.screenWidth, height: FCConstant.screenHeight)
        view.tag = 1001
        activityView.startAnimating()
        activityView.center = CGPoint(x: view.bounds.size.width * 0.5, y: view.bounds.size.height * 0.5)
        view.addSubview(activityView)
        keywindow()?.addSubview(view)
    }
    
    static func hideHUD() {
        let view = keywindow()?.viewWithTag(1001)
        if(view != nil && view?.superview != nil) {
            view?.removeFromSuperview()
        }
    }
    
    static func keywindow() ->  UIWindow? {
        if #available(iOS 13.0, *) {
            if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                return keyWindow
            }
        } else {
            if let keyWindow = UIApplication.shared.keyWindow {
                return keyWindow
            }
        }
        return nil
    }
}
