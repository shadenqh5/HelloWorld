//
//  DayCircle.swift
//  MyApp
//
//  Created by Shaden on 15/11/2026.
//

import SwiftUI

struct DayCircle: View {
    let letter: String // S M T W T F S
    let number: Int
    let status: DayStatus // decides the colors
    let isToday: Bool // today with nothing logged gets the solid orange circle

    private var textColor: Color {
        switch status {
        case .learned: return .orange
        case .frozen: return .cyan
        case .none: return .white
        }
    }

    private var circleColor: Color {
        switch status {
        case .learned: return Color.orange.opacity(0.2) // dim orange from the design
        case .frozen: return Color.cyan.opacity(0.2)
        case .none: return isToday ? .orange : .clear
        }
    }

    var body: some View {
        VStack(spacing: 6) {
            Text(letter)
                .font(.caption2)
                .bold()
                .foregroundStyle(.white)

            Text("\(number)")
                .font(.body)
                .foregroundStyle(textColor)
                .frame(width: 40, height: 40)
                .background(circleColor, in: Circle())
        }
    }
}
