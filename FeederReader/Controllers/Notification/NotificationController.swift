//
//  NotificationController.swift
//  FeederReader
//
//  Created by Admin on 10/19/17.
//  Copyright © 2017 Sheeja. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

class NotificationController {
    
    let center = UNUserNotificationCenter.current()
    
    class var shared: NotificationController {
        struct Singleton {
            static let instance = NotificationController()
        }
        return Singleton.instance
    }
    
    func requestPermissions() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            } else {
                self.setupNotifications()
            }
        }
    }
    
    func setupNotifications() {
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                
                // Content
                let content = UNMutableNotificationContent()
                content.title = "Trending News"
                content.body = "Good morning! Check out today's news!"
                content.sound = UNNotificationSound.default()
                
                // Trigger - set daily notification at 8:00:10 AM
                var dateComponents = DateComponents()
                dateComponents.hour = 8
                dateComponents.minute = 0
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                // Scheduling
                let identifier = "DailyNotification"
                let request = UNNotificationRequest(identifier: identifier,
                                                    content: content, trigger: trigger)
                self.center.add(request, withCompletionHandler: { (error) in
                    if error != nil {
                        // Something went wrong
                    } else {
                        print("Successfully registered for notifications!")
                    }
                })
            }
        }
    }
}
