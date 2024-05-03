//
//  SettingsView.swift
//  Done
//
//  Created by Rishi Venkat on 12/3/23.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    //Settings for the app. Enables dark mode and changes the accent color
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Dark Mode", isOn: $isDarkModeEnabled)
                    
                    Picker("Accent Color", selection: $settingsManager.accentColor) {
                        ForEach(UIVals.AccentColor.allCases, id: \.self) { color in
                            Text(color.rawValue.capitalized).tag(color)
                        }
                    }
                }
                
                //Logout Functionality
                /*Section {
                    Button("Log Out", action: {
                        print("logging out")
                        do {
                            print("logging")
                            try Auth.auth().signOut()
                            presentationMode.wrappedValue.dismiss() // Dismiss the view
                        } catch let error {
                            print("Error signing out: \(error.localizedDescription)")
                        }
                        
                    })
                    .foregroundColor(.red)
                
                }*/
            }
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}
