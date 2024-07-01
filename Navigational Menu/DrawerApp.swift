//
//  SIdeDrawer_App.swift
//  SIdeDrawer[
//
//  Created by garyberry09 on 6/30/24.
//

import SwiftUI

@main
struct SIdeDrawer_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
