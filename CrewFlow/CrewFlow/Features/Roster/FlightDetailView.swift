import SwiftUI

struct FlightDetailView: View {
    let flight: Flight

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // Title + route
                VStack(alignment: .leading, spacing: 8) {
                    Text(flight.flightNumber)
                        .font(.largeTitle.bold())

                    Text("\(flight.origin) → \(flight.destination)")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.secondary)
                }

                // Time + status
                HStack(spacing: 16) {
                    Label {
                        Text(flight.departureTime)
                            .font(.title3.weight(.semibold))
                    } icon: {
                        Image(systemName: "clock")
                    }

                    Spacer()

                    statusBadge
                }

                Divider()

                // Simple details table
                VStack(alignment: .leading, spacing: 8) {
                    Text("Flight Details")
                        .font(.headline)

                    detailRow(label: "Status", value: flight.status.rawValue)
                    detailRow(label: "Origin", value: flight.origin)
                    detailRow(label: "Destination", value: flight.destination)
                    detailRow(label: "Departure", value: flight.departureTime)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Flight Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews

    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
        }
    }

    private var statusBadge: some View {
        Text(flight.status.rawValue)
            .font(.caption.bold())
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(statusColor.opacity(0.15))
            .foregroundStyle(statusColor)
            .clipShape(Capsule())
    }

    private var statusColor: Color {
        switch flight.status {
        case .onTime: return .green
        case .delayed: return .orange
        case .cancelled: return .red
        }
    }
}
#Preview {
    FlightDetailView(
        flight: Flight(
            flightNumber: "WS 123",
            origin: "YYC",
            destination: "YVR",
            departureTime: "07:45",
            departureDate: Date(),
            status: .onTime
        )
    )
}

