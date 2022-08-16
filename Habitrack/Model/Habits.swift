//
//  Habits.swift
//  Habitrack
//
//  Created by Maciej on 13/08/2022.
//

import Foundation

class Habits: ObservableObject {
    @Published var items = [HabitItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decodedItems = try? decoder.decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
