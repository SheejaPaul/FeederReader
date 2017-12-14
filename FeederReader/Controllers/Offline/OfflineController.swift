//
//  OfflineController.swift
//  FeederReader
//
//  Created by Admin on 10/18/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit

class OfflineController {
    
    let reachability: Reachability = Reachability()!
    var alert = UIAlertController()
    
    class var shared: OfflineController {
        struct Singleton {
            static let instance = OfflineController()
        }
        return Singleton.instance
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(notification:)), name: Notification.Name.reachabilityChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        reachability.stopNotifier()
    }
    
    func startNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Error starting offline controller.")
        }
    }
    
    @objc func reachabilityChanged(notification:Notification) {
        let presentedViewController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController
        if reachability.connection == .none && presentedViewController == nil {
            alert = UIAlertController(title: "Device is offline", message: "You need to be connected to the internet to be able to use this app. Please try again later.", preferredStyle: .alert)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        else {
            if presentedViewController != nil {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}
