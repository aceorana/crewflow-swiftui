import SwiftUI

struct FlightDetailView: View {
    let flight: Flight

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                // MARK: Header card
                VStack(alignment: .leading, spacing: 8) {
                    Text(flightDisplayNumber)
                        .font(.system(.title2, design: .rounded).weight(.semibold))

                    Text("\(flight.origin) → \(flight.destination)")
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text("\(flight.departureTime) – \(flight.arrivalTime)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(flight.status.rawValue)
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(statusColor.opacity(0.18))
                        .foregroundStyle(statusColor)
                        .clipShape(Capsule())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 4, y: 2)
                )

                // MARK: Details card
                VStack(alignment: .leading, spacing: 12) {
                    if let marketingCarrier = flight.marketingCarrier,
                       !marketingCarrier.trimmingCharacters(in: .whitespaces).isEmpty {
                        DetailRow(label: "Marketing carrier", value: marketingCarrier)
                    }

                    DetailRow(label: "Origin", value: flight.origin)
                    DetailRow(label: "Destination", value: flight.destination)
                    DetailRow(label: "Departure time", value: flight.departureTime)
                    DetailRow(label: "Arrival time", value: flight.arrivalTime)

                    if let position = flight.position,
                       !position.isEmpty {
                        DetailRow(label: "Position", value: position)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.westJetSoftBackground)
                )
            }
            .padding()
            .background(Color(.systemGroupedBackground))
        }
        .navigationTitle("Flight Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Helpers

    private var flightDisplayNumber: String {
        "\(flight.marketingCarrier ?? "") \(flight.flightNumber)"
            .trimmingCharacters(in: .whitespaces)
    }

    private var statusColor: Color {
        switch flight.status {
        case .onTime:
            return .westJetTeal
        case .delayed:
            return Color.orange
        case .cancelled:
            return Color.red
        }
    }
}

// Reusable label/value row
private struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .font(.subheadline)
        }
    }
}
