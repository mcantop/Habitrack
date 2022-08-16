//
//  HabitView.swift
//  Habitrack
//
//  Created by Maciej on 14/08/2022.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var habits: Habits
    var item: HabitItem
    
    var body: some View {
        List {
            Text(item.title)
            Text(item.description)
            Text("Category: \(item.category.rawValue)")
            
            Section {
                HStack {
                    Button("+") {
                        var timesCompleted = item.timesCompleted
                        timesCompleted += 1
                        let activityInArray = habits.items.firstIndex(of: item)
                        habits.items[activityInArray!].timesCompleted = timesCompleted
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.bordered)

                    Text(item.timesCompleted.formatted())
                        .frame(maxWidth: .infinity)
                    
                    Button("-") {
                        var timesCompleted = item.timesCompleted
                        timesCompleted -= 1
                        let activityInArray = habits.items.firstIndex(of: item)
                        habits.items[activityInArray!].timesCompleted = timesCompleted
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.plain)
                    .foregroundColor(.accentColor)

                }
            } header: {
                Text("Times completed")
            }
            .frame(maxWidth: .infinity)

        }
        .navigationTitle("\(item.title) details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habits: Habits(), item: HabitItem(title: "test", description: "test desc", category: .hobby, timesCompleted: 7))
    }
}
