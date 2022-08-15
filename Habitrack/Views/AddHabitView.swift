//
//  AddHabitView.swift
//  Habitrack
//
//  Created by Maciej on 13/08/2022.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var habits: Habits
    @State private var title = ""
    @State private var description = ""
    @State private var category: HabitCategory = .physicalHealth
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                } header: {
                    Text("Title and description")
                }
                
                Section {
                    Picker("Category", selection: $category) {
                        ForEach(HabitCategory.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Category")
                }
                
                Section {
                    Button {
                        let habitItem = HabitItem(
                            title: title,
                            description: description,
                            category: category,
                            timesCompleted: 0
                        )
                        habits.items.append(habitItem)
                        dismiss()
                    } label: {
                        Text("Add")
                    }
                    
                }
            }
            .navigationTitle("Add a habit")
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
