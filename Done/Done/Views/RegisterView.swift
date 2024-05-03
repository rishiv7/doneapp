//
//  RegisterView.swift
//  Done
//
//  Created by Rishi Venkat on 11/24/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var validationError: String?

    var body: some View {
        ZStack {
            Color(UIVals.backgColor)
                       .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()

                UIVals.ViewTitleText("Register")
                    .padding(.bottom, 70)
                    .padding(.top, 70)

                

                VStack(alignment: .leading) {
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


                VStack (alignment: .leading){
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

                
                VStack (alignment: .leading) {
                    Text("Confirm Password:")
                        .foregroundColor(.white)
                        .bold()
                        .font(.headline)
                        .padding(.horizontal, 35)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(UIVals.RoundedTextFieldStyle())
                        .padding([.horizontal, .bottom])
                        .autocorrectionDisabled(true)
                    .foregroundColor(UIVals.accentColor)
                }

                
                if let validationError = validationError {
                    Text(validationError)
                        .foregroundColor(.red)
                }

                Button("Register") {
                    validateAndRegister()
                }        .buttonStyle(UIVals.AestheticButtonStyle())

                Spacer()
            }
        }
    }
    
    
    
    //function to validate the entry to make sure email and password meet requirements
    private func validateAndRegister() {
        // Reset previous error message
        self.validationError = nil

        // Perform validation
        if !isValidEmail(email) {
            self.validationError = "Please enter a valid email address."
            return
        }

        if password.count < 7 {
            self.validationError = "Password must be at least 7 characters long."
            return
        }

        if password != confirmPassword {
            self.validationError = "Passwords do not match."
            return
        }

        // Proceed with registration
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                self.validationError = error.localizedDescription
            } else {
                
            }
        }
    }

    //function to check if the email is valid
    private func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPred.evaluate(with: email)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
