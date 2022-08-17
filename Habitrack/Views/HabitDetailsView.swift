//
//  HabitView.swift
//  Habitrack
//
//  Created by Maciej on 14/08/2022.
//

import SwiftUI

struct HabitDetailsView: View {
    @ObservedObject var habits: Habits
    var item: HabitItem
    
    @State private var newTitle = ""
    @State private var newDescription = ""
    @State private var showAlert = false
    @State private var showAlertDelete = false
    
    var body: some View {
        List {
            TextField("Habit title", text: $newTitle)
                .onSubmit {
                    if newTitle.isEmpty {
                        showAlert = true
                    } else {
                        let activityInArray = habits.items.firstIndex(of: item)
                        habits.items[activityInArray!].title = newTitle
                    }
                }
                .onAppear {
                    newTitle = item.title
                    newDescription = item.description
                }
            TextField("Habit description", text: $newDescription)
                .onSubmit {
                    let habitInArray = habits.items.firstIndex(of: item)
                    habits.items[habitInArray!].description = newDescription
                }
            
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
            
            Section {
                Text(item.category.rawValue)
                    .foregroundColor(categoryColor(item: item.category))
                
            } header: {
                Text("Category")
            }
            
            Section {
                Text(item.date.formatted(date: .abbreviated, time: .shortened))
                    .foregroundColor(.gray)
            } header: {
                Text("Created")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Title can not be empty."),
                dismissButton: .default(Text("OK")) {
                    showAlert = false
                    let activityInArray = habits.items.firstIndex(of: item)
                    newTitle = habits.items[activityInArray!].title
                }
            )
        }
        .navigationTitle("\(item.title) details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    showAlertDelete = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .alert(isPresented: $showAlertDelete) {
            Alert(
                title: Text("Delete habit"),
                message: Text("Are you sure you want to delete '\(item.title)' habit?"),
                primaryButton: .cancel(
                    Text("Cancel")
                ),
                secondaryButton: .destructive(
                    Text("Delete"),
                    action: {
                        let activityInArray = habits.items.firstIndex(of: item)
                        habits.items.remove(at: activityInArray!)
                    }
                )
            )
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailsView(habits: Habits(), item: HabitItem(title: "test", description: "test desc", category: .hobby, timesCompleted: 7, date: Date.now))
    }
}
