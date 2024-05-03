//
//  AddHabitView.swift
//  Done
//
//  Created by Rishi Venkat on 11/28/23.
//

import SwiftUI
import CoreData
import FirebaseAuth

struct AddHabitView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var habitName: String = ""
    @State private var goalDays: Int = 0
    @State private var habitFrequency: String = "Daily"
    @State private var showingHabitNameError: Bool = false
    @State private var showingInfoAlert: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Habit Details")) {
                    // Sets the habit Name
                    TextField("Habit Name", text: $habitName)
                    
                    //Sets the goal days
                    Stepper("Goal Days: \(goalDays)", value: $goalDays, in: 0...365)
                }

                Section(header: HStack {
                    //sets the habit frequency
                    Text("Habit Frequency")
                    Spacer()
                    Button(action: {
                        showingInfoAlert = true
                    }) {
                        Image(systemName: "info.circle")
                    }
                    .alert(isPresented: $showingInfoAlert) {
                        Alert(title: Text("Habit Frequency"),
                              message: Text("Is this a habit that should be completed once every day or once every week?"),
                              dismissButton: .default(Text("Got it!")))
                    }
                }) {
                    Picker("Frequency", selection: $habitFrequency) {
                        Text("Daily").tag("Daily")
                        Text("Weekly").tag("Weekly")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                //button to add new habit
                Section {
                    HStack {
                        
                        Spacer()
                        Button(action: addNewHabit) {
                            Text("Add Habit")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(UIVals.AccentButtonStyle())
                        .padding()
                        Spacer()
                        
                        //habit must have a habit name
                        if showingHabitNameError {
                            Text("Please enter a habit name")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                
            }
            .navigationBarTitle("Add New Habit", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }.accentColor(UIVals.accentColor)
    }

    //adds new habit to context
    private func addNewHabit() {
        if habitName.isEmpty {
            showingHabitNameError = true
            return
        }

        let newHabit = HabitEntity(context: viewContext)
        newHabit.habitName = habitName
        newHabit.goalDays = Int32(goalDays)
        newHabit.daily = habitFrequency
        newHabit.currStreak = 0
        newHabit.longestStreak = 0
        newHabit.totalGP = 0
        newHabit.userEmail = Auth.auth().currentUser?.email
        newHabit.timestamp = Date()
        newHabit.habitID = UUID()
        newHabit.completedDates = []
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving habit: \(error)")
        }
    }
}

struct RectangularButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}



struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
