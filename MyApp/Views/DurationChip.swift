//
//  DurationChip.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//

import SwiftUI

struct DurationChip: View {
    let title: String // text shown on the chip
    let isSelected: Bool // decides the orange or grey look; the chip never stores this itself
    let action: () -> Void // what happens on tap, supplied by whoever uses the chip

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(isSelected ? Color.white : Color.gray) // condition ? if true : if false
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.orange : Color.white.opacity(0.1), in: Capsule()) // pill shape behind the text
        }
    }
}
