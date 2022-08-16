//
//  ContentView.swift
//  Habitrack
//
//  Created by Maciej on 13/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingSheet = false
    @State private var searchString = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { item in
                    HabitRow(habits: habits, item: item)
                }
                .onMove(perform: move)
                .onDelete(perform: removeItems)
            }
            .listStyle(.plain)
            .refreshable { }
            .navigationTitle("Habitrack")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Text("New habit")
                    }
                    .sheet(isPresented: $showingSheet) {
                        AddHabitView(habits: habits)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        habits.items.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
