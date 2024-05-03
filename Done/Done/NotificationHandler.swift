//
//  NotificationHandler.swift
//  Done
//
//  Created by Rishi Venkat on 12/2/23.
//

import Foundation
import UserNotifications
import CoreData


class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //processEndOfDayHabits()
        completionHandler()
    }

   /* func processEndOfDayHabits() {
        // Fetch all habits and update their completion status
        let fetchRequest: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        if let habits = try? context.fetch(fetchRequest) {
            for habit in habits {
                if habit.statusToday {
                    habit.completedDates?.append(Date())
                }
                habit.statusToday = false // Reset the status for the next day
            }
            do {
                try context.save()
            } catch {
                // Handle error
                print(error)
            }
        }
    } */
}
