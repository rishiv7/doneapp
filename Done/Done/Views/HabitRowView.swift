//
//  HabitRowView.swift
//  Done
//
//  Created by Rishi Venkat on 11/28/23.
//

import SwiftUI
import CoreData

struct HabitRowView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var habitEntity: HabitEntity
    @EnvironmentObject var settingsManager: SettingsManager
    
    //contains a list of the previous circles and the completion tracker for today
    var body: some View {
        HStack {
            Text(habitEntity.habitName ?? "Unknown Habit")
                .bold()
                .lineLimit(1)
                .foregroundColor(UIVals.accentColor)
            Spacer()
            
            HStack(spacing: 4) {
                let completionStatus = habitEntity.calculateCompletionStatus()
                ForEach(completionStatus.indices, id: \.self) { index in
                    UIVals.StatusCircleView(isComplete: completionStatus[index])
                }
                
                CurrentStatusCircleView(habitEntity: habitEntity)

            }
            
            Text("Streak: \(habitEntity.currStreak)")
                .padding(.trailing)
        }
        .padding(.vertical, 4)
        .onAppear {
            resetStatusIfNeeded()
            habitEntity.updateCurrStreak()
        }
    }
    
    //reset status for completion circle every day
    private func resetStatusIfNeeded() {
        guard let completedDates = habitEntity.completedDates else { return }
        let today = Calendar.current.startOfDay(for: Date())
        // below is used for adding data to previous dates
        // let today = Calendar.current.date(byAdding: .day, value: -4, to: Date())!
        if let lastCompletionDate = completedDates.last {
            if !Calendar.current.isDate(today, inSameDayAs: lastCompletionDate) {
                habitEntity.statusToday = false
                try? context.save()
                habitEntity.updateCurrStreak() // Update currStreak during daily reset

            }
        }
        print("completedDates: \(completedDates)")

        }
    
}

//Circle for the current status
struct CurrentStatusCircleView: View {
    @ObservedObject var habitEntity: HabitEntity
    @Environment(\.managedObjectContext) var context

    var body: some View {
            Button(action: toggleStatus) {
                Image(systemName: habitEntity.statusToday ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 23, height: 23)
                    .foregroundColor(habitEntity.statusToday ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle()) // To make it look like a non-button view
            .onTapGesture {
                toggleStatus()
            }
        }

    //toggle status
    private func toggleStatus() {
        if !habitEntity.statusToday {
            habitEntity.statusToday = true
            let today = Date()
            //was used to add data
            //let today = Calendar.current.date(byAdding: .day, value: -4, to: Date())!
            if var completedDates = habitEntity.completedDates {
                completedDates.append(today)
                habitEntity.completedDates = completedDates
                habitEntity.updateCurrStreak()
                print(habitEntity.currStreak)
            }
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}



