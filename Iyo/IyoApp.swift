//
//  IyoApp.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import SwiftUI

@main
struct IyoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
