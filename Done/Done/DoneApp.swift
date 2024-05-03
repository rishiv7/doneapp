//
//  DoneApp.swift
//  Done
//
//  Created by Rishi Venkat on 11/23/23.
//

import SwiftUI
import FirebaseCore
import Firebase

@main
struct DoneApp: App {
    @AppStorage("isDarkModeEnabled") var isDarkModeEnabled: Bool = false
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
    }
    

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)     .environmentObject(SettingsManager.shared)
                .preferredColorScheme(isDarkModeEnabled ? .dark : .light)


        }
    }
    
    
}
