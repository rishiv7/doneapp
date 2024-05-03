//
//  ContentView.swift
//  Done
//
//  Created by Rishi Venkat on 11/23/23.
//

import SwiftUI
import CoreData
import FirebaseCore
import Firebase
import UIKit



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

import SwiftUI

//Shows a splash screen for 2 seconds and then shows the loginView
struct ContentView: View {
    @State private var isActive = false
    @State private var isAuthenticated = false

    var body: some View {
        
        VStack {
            if isAuthenticated {
                HomeView()
            } else if isActive {
                LoginView(isAuthenticated: $isAuthenticated)
            } else {
                SplashScreenView()
            }
        }
        .onAppear {
            // Delay for the splash screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color(UIVals.backgColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer()
                Text("WILL DO")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .strikethrough(true)
                    .padding(.bottom, -20)

                Text("DONE")
                    .font(.system(size: 56))
                    .bold()
                    .italic()
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

