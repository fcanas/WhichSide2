//
//  SidesApp.swift
//  Sides WatchKit Extension
//
//  Created by Fabián Cañas on 2/2/21.
//

import SwiftUI

@main
struct SidesApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
