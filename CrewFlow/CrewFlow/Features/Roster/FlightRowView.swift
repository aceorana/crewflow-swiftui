//
//  FlightRowView.swift
//  CrewFlow
//
//  Created by user278387 on 12/7/25.
//

import SwiftUI

struct FlightRowView: View {
    let flight: Flight

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Left: number, route, position
            VStack(alignment: .leading, spacing: 4) {
                // e.g. "WS 123"
                Text(flightDisplayNumber)
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(.primary)

                HStack(spacing: 6) {
                    Text("\(flight.origin) → \(flight.destination)")
                        .font(.subheadline)
                    Text("·")
                    Text(flight.departureTime)
                }
                .foregroundStyle(.secondary)

                if let position = flight.position,
                   !position.isEmpty {
                    Text(position)
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.secondary.opacity(0.06))
                        .foregroundStyle(.secondary)
                        .clipShape(Capsule())
                }
            }

            Spacer()

            // Right: colored status chip, aligned near top
            Text(flight.status.rawValue)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(statusColor.opacity(0.18))
                .foregroundStyle(statusColor)
                .clipShape(Capsule())
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle()) // full row tappable
    }

    // MARK: - Helpers

    private var flightDisplayNumber: String {
        "\(flight.marketingCarrier ?? "") \(flight.flightNumber)"
            .trimmingCharacters(in: .whitespaces)
    }

    private var statusColor: Color {
        switch flight.status {
        case .onTime:
            // use teal as the "good" color
            return .westJetTeal
        case .delayed:
            // warm amber for delay
            return Color.orange
        case .cancelled:
            // softer red so it’s not screaming
            return Color.red
        }
    }
}
