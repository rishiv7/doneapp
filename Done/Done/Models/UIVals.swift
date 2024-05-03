//
//  UIVals.swift
//  Done
//
//  Created by Rishi Venkat on 11/28/23.
//

import Foundation
import SwiftUI
import UIKit


class UIVals {
    static var accentColor: Color {
        SettingsManager.shared.accentColor.color
    }

    enum AccentColor: String, CaseIterable, Identifiable {
        case green, red
        var color: Color {
            switch self {
            case .green:
                return Color(red: 0.2156862745, green: 0.8039215686, blue: 0.168627451, opacity: 1.0)
            case .red:
                // Directly converting hex to Color
                return Color(red: 1.0, green: 0.2862745098, blue: 0.231372549, opacity: 1.0)
            }
        }
        var id: Self { self }
    }
    
    struct AestheticButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200, height: 50)
                .background(Color.black)
                .cornerRadius(25)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
        }
    }
        
    struct AestheticButtonStyle2: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200, height: 50)
                .background(Color(red: 0.3, green: 0.3, blue: 0.3))
                .cornerRadius(25)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
        }
    }
    
    struct AccentButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 200, height: 50)
                .background(accentColor)
                .cornerRadius(25)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
        }
    }
    
    static let backgColor = accentColor
    
    struct RoundedTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding()
                .background(Color.white) // White background
                .cornerRadius(15) // Fully rounded ends
                .shadow(color: .gray, radius: 2, x: 0, y: 2) // Shadow for depth
                .padding(.horizontal)
        }
    }
    
    struct ViewTitleTextStyle: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.white)
            }
        }

    struct SubViewTitleTextStyle: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(.largeTitle)
                    .bold()
                    .italic()
                    .foregroundColor(accentColor)
                    .padding()
            }
        }
    
    static func ViewTitleText(_ text: String) -> some View {
        Text(text)
            .modifier(ViewTitleTextStyle())
    }
    
    static func SubViewTitleText(_ text: String) -> some View {
        Text(text)
            .modifier(SubViewTitleTextStyle())
    }
    
    struct StatusCircleView: View {
        var isComplete: Bool
        
        var body: some View {
            Image(systemName: isComplete ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(isComplete ? .green : .red)
                .font(.caption) // Adjust the size to match the smaller circles
        }
    }
    
    

}
