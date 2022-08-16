//
//  AssignColors.swift
//  Habitrack
//
//  Created by Maciej on 15/08/2022.
//

import SwiftUI

func categoryColor(item: HabitCategory) -> Color {
    switch item {
    case .physicalHealth:
        return Color.green
    case .mentalHealth:
        return Color.red
    case .hobby:
        return Color.purple
    case .fitness:
        return Color.cyan
    case .work:
        return (Color.gray)
    }
}
