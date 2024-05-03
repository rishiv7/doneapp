//
//  SettingsManager.swift
//  Done
//
//  Created by Rishi Venkat on 12/4/23.
//

import Foundation

class SettingsManager: ObservableObject {
    @Published var accentColor: UIVals.AccentColor = .green
    static let shared = SettingsManager()
}

