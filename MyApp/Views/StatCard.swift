//
//  StatCard.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//


import SwiftUI

struct StatCard: View {
    let symbol: String // SF Symbol name
    let tint: Color // orange for learned, blue for frozen
    let value: String // already formatted, e.g. "4 Days"
    let label: String // "Learned" or "Freezed"

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: symbol)
                .foregroundStyle(tint)

            Text(value)
                .font(.headline)
                .foregroundStyle(.white)

            Text(label)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 24)) // plain Liquid Glass card, no tint
    }
}
