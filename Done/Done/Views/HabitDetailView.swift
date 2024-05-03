//
//  HabitDetailView.swift
//  Done
//
//  Created by Rishi Venkat on 12/4/23.
//

import SwiftUI

struct HabitDetailView: View {
    let habitName: String
    let daysCompleted: Int
    let goalDays: Int

    //Contains the habit name, the days to go, and the goal number of days
    var body: some View {
        VStack {
            Spacer()

            Text(habitName)
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(UIVals.accentColor)
                .bold()
                .italic()
                .padding(.bottom, 30)
            
            Text("Days Completed: \(daysCompleted)")
                .font(.system(size: 30, weight: .semibold))
                .padding(.bottom, 20)

            if daysCompleted < goalDays {
                Text("Goal: \(goalDays - daysCompleted) days to go")
                    .font(.system(size: 30, weight: .semibold))
            } else {
                Text("SUCCESS")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(UIVals.accentColor)
                    .bold()
            }

            Spacer()
        }
        .padding()
        .navigationBarTitle("Habit Details", displayMode: .inline)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habitName: "Exercise", daysCompleted: 10, goalDays: 30)
    }
}
