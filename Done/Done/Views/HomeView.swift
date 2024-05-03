//
//  HomeView.swift
//  Done
//
//  Created by Rishi Venkat on 11/28/23.
//

import SwiftUI
import CoreData
import FirebaseAuth

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddHabitView = false
    @EnvironmentObject var settingsManager: SettingsManager
    
    //Fetches habits from Core Data
    @FetchRequest(
        entity: HabitEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \HabitEntity.timestamp, ascending: false)],
        predicate: NSPredicate(format: "userEmail == %@", Auth.auth().currentUser?.email ?? "")
    ) var habitEntities: FetchedResults<HabitEntity>
    
    
    // State variable to keep track of the habit being deleted
    @State private var habitToDelete: HabitEntity? = nil
    
    //View contains list of habits in a table view, the done app logo centered, and the nav items to settings, and add habit
    var body: some View {
        
        NavigationView {
            VStack {
                HStack{
                    Spacer()
                    UIVals.SubViewTitleText("DONE").foregroundColor(UIVals.accentColor)
                    Spacer()
                    
                }
                List {
                    ForEach(habitEntities, id: \.self) { habitEntity in
                        NavigationLink(destination: HabitDetailView(habitName: habitEntity.habitName ?? "", daysCompleted: habitEntity.completedDates?.count ?? 0, goalDays: Int(habitEntity.goalDays))) {
                            HabitRowView(habitEntity: habitEntity)
                        }
                    }.onDelete(perform: confirmDeletion)
                }
                .alert(item: $habitToDelete) { habitToDelete in
                    Alert(
                        title: Text("Are you sure you want to delete this habit?"),
                        message: Text("Habits cannot be recovered once deleted."),
                        primaryButton: .destructive(Text("Delete")) {
                            viewContext.delete(habitToDelete)
                            try? viewContext.save()
                        },
                        secondaryButton: .cancel()
                    ) }
                
                .navigationBarItems(trailing: Button(action: {
                    showingAddHabitView = true
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $showingAddHabitView) {
                    AddHabitView().environment(\.managedObjectContext, viewContext)
                }
                .navigationBarItems(leading: NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                })
            }

        }
        .accentColor(UIVals.accentColor)
        .onAppear {
            refreshHabits()
        }
    }
    
    //deletes the habit
    private func confirmDeletion(at offsets: IndexSet) {
        offsets.forEach { index in
            habitToDelete = habitEntities[index]
        }
    }

    //refreshes the list of habits
    private func refreshHabits() {
            for habitEntity in habitEntities {
                let habitCurr = convertToHabit(habitEntity)
                habitCurr.objectWillChange.send()
            }
        }
    
    //function to convert habit entity into actual habit
    private func convertToHabit(_ habitEntity: HabitEntity) -> Habit {
        let habit = Habit()
        habit.currStreak = habitEntity.currStreak
        habit.daily = habitEntity.daily ?? "Daily"
        habit.daysMade = habitEntity.daysMade
        habit.daysMissed = habitEntity.daysMissed
        habit.goalDays = habitEntity.goalDays
        habit.habitName = habitEntity.habitName ?? "None"
        habit.longestStreak = habitEntity.longestStreak
        habit.totalGP = habitEntity.totalGP
        habit.userEmail = habitEntity.userEmail ?? "None"
        habit.habitID = habitEntity.habitID ?? UUID()
        return habit
    }

}
