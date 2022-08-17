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
    @State private var category: HabitCategory = .fitness
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Habit title", text: $title)
                } header: {
                    Text("Title")
                }
                
                Section {
                    TextField("Habit description", text: $description)
                } header: {
                    Text("Description")
                }
                
                Section {
                    Picker("Category", selection: $category) {
                        ForEach(HabitCategory.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                } header: {
                    Text("Category")
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("New habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                    }
                }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if title.isEmpty {
                                showAlert = true
                            } else {
                                let habitItem = HabitItem(
                                    title: title,
                                    description: description,
                                    category: category,
                                    timesCompleted: 0,
                                    date: Date.now
                                )
                                habits.items.append(habitItem)
                                dismiss()
                            }
                        } label: {
                            Text("Add")
                        }

                    
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Title can not be empty."),
                    dismissButton: .default(Text("OK")) {
                        showAlert = false
                    }
                )
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
