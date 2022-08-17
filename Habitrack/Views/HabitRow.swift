//
//  HabitRow.swift
//  Habitrack
//
//  Created by Maciej on 15/08/2022.
//

import SwiftUI

struct HabitRow: View {
    @ObservedObject var habits: Habits
    var item: HabitItem
    
    @State private var isPresentingHabit = false
    
    var body: some View {
        HStack(spacing: 14) {
            Button {
                var timesCompleted = item.timesCompleted
                timesCompleted += 1
                let habitInArray = habits.items.firstIndex(of: item)
                habits.items[habitInArray!].timesCompleted = timesCompleted
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .black)
                    .frame(width: 25, height: 25)
                    .padding(15)
                HStack {
                    Image(systemName: "forward.fill")
                    Text(item.timesCompleted.formatted())
                }
                .font(.caption2)
                .foregroundColor(.black)
                .padding(.leading, -25)
                .frame(width: 30)
            }
            .buttonStyle(.plain)
            .background(categoryColor(item: item.category))
            
            Button {
                isPresentingHabit = true
            } label: {
                if item.description.isEmpty {
                    Text(item.title)
                        .contentShape(Rectangle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    VStack(spacing: 3) {
                        Text(item.title)
                            .contentShape(Rectangle())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(item.description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                    }
                    .lineLimit(1)
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .buttonStyle(.plain)
            
            NavigationLink(destination: HabitDetailsView(habits: habits, item: item), isActive: $isPresentingHabit) { }
                .frame(width: 0, height: 0)
                .hidden()
        }
        .background(Color(.tertiarySystemGroupedBackground))
        .cornerRadius(12)
        .listRowSeparator(.hidden)
    }
}

struct HabitRow_Previews: PreviewProvider {
    static var previews: some View {
        HabitRow(habits: Habits(), item: HabitItem(title: "title", description: "description", category: .work, timesCompleted: 7, date: Date.now))
    }
}
