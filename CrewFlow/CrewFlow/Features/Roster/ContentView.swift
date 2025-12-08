import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RosterViewModel()
    @State private var showingAddFlight = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Empty state overlay
                if viewModel.filteredFlights.isEmpty {
                    emptyStateView
                }

                List {
                    // Filter row as list header
                    Section {
                        dutyFilterPicker
                    }

                    // Flights
                    ForEach(viewModel.filteredFlights) { flight in
                        NavigationLink(value: flight) {
                            FlightRowView(flight: flight)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Today's Roster")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddFlight = true
                    } label: {
                        Label("Add Duty", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddFlight) {
                AddFlightView(viewModel: viewModel)
            }
            .background(Color(.systemGroupedBackground))
            .navigationDestination(for: Flight.self) { flight in
                FlightDetailView(flight: flight)
            }
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search flight #, airport, or position"
            )
        }
    }


    // MARK: - Subviews

    private var dutyFilterPicker: some View {
        Picker("Duty Filter", selection: $viewModel.selectedDutyFilter) {
            ForEach(RosterViewModel.DutyFilter.allCases) { filter in
                Text(filter.rawValue).tag(filter)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }

    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "airplane.departure")
                .font(.system(size: 40, weight: .medium))
            Text("No roster items match your filters.")
                .font(.headline)
            Text("Try changing the duty type or clearing your search.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

//    private func flightRow(for flight: Flight) -> some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 4) {
//                // e.g. "WS 123"
//                Text("\(flight.marketingCarrier ?? "") \(flight.flightNumber)".trimmingCharacters(in: .whitespaces))
//                    .font(.headline)
//
//                HStack(spacing: 6) {
//                    Text("\(flight.origin) → \(flight.destination)")
//                        .font(.subheadline)
//                    Text("·")
//                    Text(flight.departureTime)
//                }
//                .foregroundStyle(.secondary)
//
//                if let position = flight.position {
//                    Text(position)
//                        .font(.caption)
//                        .padding(.horizontal, 6)
//                        .padding(.vertical, 2)
//                        .background(Color.secondary.opacity(0.1))
//                        .clipShape(Capsule())
//                }
//            }
//
//            Spacer()
//
//            Text(flight.status.rawValue)
//                .font(.caption)
//                .padding(.horizontal, 6)
//                .padding(.vertical, 4)
//                .background(statusColor(for: flight.status).opacity(0.15))
//                .foregroundStyle(statusColor(for: flight.status))
//                .clipShape(Capsule())
//        }
//        .padding(.vertical, 6)
//    }

//    private func statusColor(for status: FlightStatus) -> Color {
//        switch status {
//        case .onTime: return .green
//        case .delayed: return .orange
//        case .cancelled: return .red
//        }
//    }
}
