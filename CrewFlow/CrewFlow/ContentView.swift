import SwiftUI

struct ContentView: View {
    // Later this will come from a ViewModel
    let flights = SampleData.todaysFlights

    var body: some View {
        NavigationStack {
            List(flights) { flight in
                FlightRow(flight: flight)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Today’s Roster")
        }
    }
}

struct FlightRow: View {
    let flight: Flight

    private var statusColor: Color {
        switch flight.status {
        case .onTime: return .green
        case .delayed: return .orange
        case .cancelled: return .red
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(flight.flightNumber)
                    .font(.headline)

                Text("\(flight.origin) → \(flight.destination)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(flight.departureTime)
                    .font(.headline)

                Text(flight.status.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor.opacity(0.15))
                    .foregroundStyle(statusColor)
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
