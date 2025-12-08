import Foundation
import Combine

final class RosterViewModel: ObservableObject {

    // MARK: - Filter types

    enum DutyFilter: String, CaseIterable, Identifiable {
        case all = "All"
        case flight = "Flight"
        case ground = "Ground"
        case layover = "Layover"

        var id: String { rawValue }
    }

    // MARK: - Raw flights (loaded / persisted)

    @Published var flights: [Flight] = [] {
        didSet {
            // Persist to disk whenever the list changes
            FlightStorage.save(flights)
            applyFilters()
        }
    }

    // MARK: - Filter & Search State

    @Published var searchText: String = "" {
        didSet { applyFilters() }
    }

    @Published var selectedDutyFilter: DutyFilter = .all {
        didSet { applyFilters() }
    }

    // What the UI actually shows
    @Published var filteredFlights: [Flight] = []

    // MARK: - Init

    init() {
        let saved = FlightStorage.load()
        if saved.isEmpty {
            flights = SampleData.upcomingFlights   
        } else {
            flights = saved
        }

        applyFilters()
    }

    // MARK: - Test helper (for persistence)
//
//    func addTestFlight() {
//        print("➡️ addTestFlight tapped")
//
//        let test = Flight(
//            flightNumber: "WS9999",
//            origin: "YYC",
//            destination: "YVR",
//            departureTime: "12:00",
//            arrivalTime: "12:45",
//            departureDate: Date(),
//            arrivalDate: Date().addingTimeInterval(60 * 60),
//            status: .onTime,
//            dutyType: .flight,
//            position: "FA1",
//            marketingCarrier: "WS",
//            notes: "Test persisted flight"
//        )
//
//        flights.append(test)  // triggers didSet → save + applyFilters
//    }

    // MARK: - Filtering logic

    private func applyFilters() {
        let today = Date()
        let trimmedSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let hasSearch = !trimmedSearch.isEmpty
        let query = trimmedSearch.lowercased()

        filteredFlights = flights.filter { flight in

            // 1) Date: only today's flights
            let isToday = Calendar.current.isDate(flight.departureDate,
                                                  inSameDayAs: today)

            // 2) Duty filter
            let dutyMatches: Bool
            switch selectedDutyFilter {
            case .all:
                dutyMatches = true
            case .flight:
                dutyMatches = (flight.dutyType == .flight)
            case .ground:
                dutyMatches = (flight.dutyType == .ground)
            case .layover:
                dutyMatches = (flight.dutyType == .layover)
            }

            // 3) Search filter
            let searchMatches: Bool
            if hasSearch {
                searchMatches =
                    flight.flightNumber.lowercased().contains(query) ||
                    flight.origin.lowercased().contains(query) ||
                    flight.destination.lowercased().contains(query) ||
                    (flight.position?.lowercased().contains(query) ?? false)
            } else {
                searchMatches = true
            }

            return isToday && dutyMatches && searchMatches
        }
    }
    
    func addFlight(
        flightNumber: String,
        origin: String,
        destination: String,
        departure: Date,
        arrival: Date,
        dutyType: DutyType,
        position: String? = nil,
        marketingCarrier: String? = nil,
        notes: String? = nil
    ) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"       // matches 07:45 style

        let departureTime = timeFormatter.string(from: departure)
        let arrivalTime = timeFormatter.string(from: arrival)

        let calendar = Calendar.current
        let departureDate = calendar.startOfDay(for: departure)
        let arrivalDate = calendar.startOfDay(for: arrival)

        let newFlight = Flight(
            flightNumber: flightNumber,
            origin: origin,
            destination: destination,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            departureDate: departureDate,
            arrivalDate: arrivalDate,
            status: .onTime,                      // default; you can make this a picker later
            dutyType: dutyType,
            position: position,
            marketingCarrier: marketingCarrier,
            notes: notes
        )

        flights.append(newFlight)                // triggers save + re-filter
    }

}
