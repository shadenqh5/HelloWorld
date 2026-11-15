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
        if isSelected {
            Button(action: action) { chipLabel }
                .buttonStyle(.glassProminent) // colored glass for the chosen chip
                .tint(Color.appOrange)
        } else {
            Button(action: action) { chipLabel }
                .buttonStyle(.glass) // neutral dark glass for the others
        }
    }

    private var chipLabel: some View { // shared by both styles so the text and size stay identical
        Text(title)
            .foregroundStyle(isSelected ? Color.white : Color.gray) // condition ? if true : if false
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
    }
}
