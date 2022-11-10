//
//  MockAPIApp.swift
//  MockAPI
//
//  Created by Gerald Stephanus on 10/11/22.
//

import SwiftUI

@main
struct MockAPIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
