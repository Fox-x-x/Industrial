//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Pavel Yurkov on 23.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationsService {
    
    func registeForLatestUpdatesIfPossible() {
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.requestAuthorization(
            options: [.sound, .badge, .provisional]
        ) { granted, error in
            
            if granted {
                print("access granted")
                
                let content = UNMutableNotificationContent()
                content.title = "Привет! :)"
                content.body = "Посмотрите последние обновления"
                content.sound = UNNotificationSound.default
                
                var dateComponents = DateComponents()
                dateComponents.hour = 21
                dateComponents.minute = 07

                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                notificationCenter.add(request)
                
            } else {
                print("access denied")
            }
          }
        
    }
    
}
