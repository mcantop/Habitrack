//
//  HabitItem.swift
//  Habitrack
//
//  Created by Maciej on 13/08/2022.
//

import Foundation

enum HabitCategory: String, CaseIterable, Codable {
    case physicalHealth = "Gym"
    case mentalHealth = "Meditation"
    case fitness = "Fitness"
    case hobby = "Hobby"
    case work = "Work"
}

struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    let category: HabitCategory
    var timesCompleted: Int
}
