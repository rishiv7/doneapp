//
//  LoginView.swift
//  Done
//
//  Created by Rishi Venkat on 11/24/23.
//

import Foundation
import SwiftUI
import FirebaseAuth
import UIKit

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @Binding var isAuthenticated: Bool

    // Variables to use context
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    // LoginView contains an email and password field, and a button to login or register
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIVals.backgColor)
                           .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    
                    UIVals.ViewTitleText("Login")
                        .padding(.bottom, 70)
                        .padding(.top, 100)
                    
                    
                    VStack(alignment: .leading){
                        Text("Email:")
                            .foregroundColor(.white)
                            .bold()
                            .font(.headline)
                            .padding(.horizontal, 35)
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(UIVals.RoundedTextFieldStyle())
                            .padding([.horizontal, .bottom])
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .keyboardType(.emailAddress)
                            .foregroundColor(UIVals.accentColor)
                    }
                    
                    VStack(alignment: .leading){
                        Text("Password:")
                            .foregroundColor(.white) // Adjust color as needed
                            .bold()
                            .font(.headline)
                            .padding(.horizontal, 35)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(UIVals.RoundedTextFieldStyle())
                            .padding([.horizontal, .bottom])
                            .autocorrectionDisabled(true)
                            .foregroundColor(UIVals.accentColor)
                    }
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Button("Login") {
                        loginUser()
                    }          .buttonStyle(UIVals.AestheticButtonStyle())
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(UIVals.AestheticButtonStyle2())
                    
                    Spacer()

                }.accentColor(Color.black)
                
            }

        }

    }
    
    
    //Login function which rights the error and provides authenticated
    private func loginUser() {
        self.errorMessage = nil
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.dismiss()
                }
            }
        }
    }
}
