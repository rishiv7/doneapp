//
//  HabitEntityExtension.swift
//  Done
//
//  Created by Rishi Venkat on 12/1/23.
//

import Foundation
import CoreData



extension HabitEntity {
    
    @nonobjc public class func fetchRequest1() -> NSFetchRequest<HabitEntity> {
        return NSFetchRequest<HabitEntity>(entityName: "HabitEntity")
    }
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.completedDates = []
    }
    
    //contains method to calculate the current streak
    func updateCurrStreak() {
        guard let completedDates = self.completedDates else {
            self.currStreak = 0
            return
        }
        
        let sortedDates = completedDates.sorted(by: { $0 > $1 })
        var currentStreak = 0
        var previousDate = Date()
        
        for date in sortedDates {
            if Calendar.current.isDate(date, inSameDayAs: previousDate) {
                currentStreak += 1
            } else if Calendar.current.isDate(date, addingDays: -1, to: previousDate) {
                currentStreak += 1
            } else {
                break
            }
            previousDate = date
        }
        
        self.currStreak = Int32(currentStreak)
    }
    
    //contains method to calculate the current the completion status of the previous 4 days
    func calculateCompletionStatus(daysBack: Int = 4) -> [Bool] {
        guard let completedDates = self.completedDates else {
            return Array(repeating: false, count: daysBack)
        }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var completionStatus = [Bool]()

        for dayIndex in (1...daysBack).reversed() {
            guard let dateToCheck = calendar.date(byAdding: .day, value: -dayIndex, to: today) else {
                completionStatus.append(false)
                continue
            }

            let dateCompleted = completedDates.contains { calendar.isDate($0, inSameDayAs: dateToCheck) }
            completionStatus.append(dateCompleted)
        }

        return completionStatus
    }
}

extension Calendar {
    func isDate(_ date1: Date, addingDays days: Int, to date2: Date) -> Bool {
        guard let modifiedDate = self.date(byAdding: .day, value: days, to: date2) else { return false }
        return isDate(date1, inSameDayAs: modifiedDate)
    }
}
