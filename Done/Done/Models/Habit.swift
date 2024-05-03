//
//  Habit.swift
//  Done
//
//  Created by Rishi Venkat on 11/28/23.
//

import Foundation

class Habit: Hashable, ObservableObject {
    var currStreak: Int32
    var daily: String
    var daysMade: Int32
    var daysMissed: Int32
    var goalDays: Int32
    var habitName: String
    var longestStreak: Int32
    var totalGP: Int32
    var userEmail: String
    var completedDates: [Date]
    var incompleteDates: [Date]
    @Published var statusToday: Bool = false
    var habitID = UUID()


    //sets defaults for habit attributes
    init() {
        self.currStreak = 0
        self.daily = "Daily"
        self.daysMade = 0
        self.daysMissed = 0
        self.goalDays = 0
        self.longestStreak = 0
        self.totalGP = 0
        self.habitName = "None"
        self.userEmail = "None"
        self.completedDates = []
        self.incompleteDates = []
        self.statusToday = false
        self.habitID = UUID()
    }
    
    static func == (lhs: Habit, rhs: Habit) -> Bool {
            lhs.habitName == rhs.habitName
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(habitName)
    }
}
