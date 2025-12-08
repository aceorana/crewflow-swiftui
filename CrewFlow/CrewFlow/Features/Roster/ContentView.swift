import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RosterViewModel()
    @State private var showingAddFlight = false
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
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
                        NavigationLink(value: flight.id) {
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
            .navigationDestination(for: Flight.ID.self) { id in
                if let flight = viewModel.flight(withId: id) {
                    FlightDetailView(flight: flight)
                } else {
                    // In case the flight was deleted or no longer matches filters
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                        Text("This duty is no longer available.")
                            .font(.headline)
                        Text("It may have been removed or changed.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
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
}
