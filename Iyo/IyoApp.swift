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
    @StateObject var  iyoListVM : IyoListVM = IyoListVM()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(iyoListVM)

        }
    }
}
