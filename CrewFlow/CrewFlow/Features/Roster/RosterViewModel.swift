//
//  RosterViewModel.swift
//  CrewFlow
//
//  Created by user278387 on 12/4/25.
//

import Foundation
import Combine

struct RosterSection: Identifiable {
    let id = UUID()
    let date: Date
    let title: String
    let flights: [Flight]
}

@MainActor
class RosterViewModel: ObservableObject {
    @Published var flights: [Flight] = []
    @Published var sections: [RosterSection] = []
    @Published var isLoading = false

    init() {
        loadRoster()
    }

    func loadRoster() {
        isLoading = true

        // Simulate async load
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            let loadedFlights = SampleData.upcomingFlights

            Task { @MainActor in
                self.flights = loadedFlights
                self.sections = self.buildSections(from: loadedFlights)
                self.isLoading = false
            }
        }
    }

    // MARK: - Private helpers
    //Grouping flights by departureDate into RosterSections and label them Today, Tomorrow or a formatted date string
    private func buildSections(from flights: [Flight]) -> [RosterSection] {
        let calendar = Calendar.current

        // Group by day
        let grouped = Dictionary(grouping: flights) { flight in
            calendar.startOfDay(for: flight.departureDate)
        }

        let sortedDates = grouped.keys.sorted()

        return sortedDates.compactMap { date in
            guard let flightsForDay = grouped[date] else { return nil }

            let sortedFlights = flightsForDay.sorted { $0.departureTime < $1.departureTime }
            let title = dayLabel(for: date)

            return RosterSection(date: date, title: title, flights: sortedFlights)
        }
    }

    private func dayLabel(for date: Date) -> String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if calendar.isDate(date, inSameDayAs: today) {
            return "Today"
        } else if let tomorrow = calendar.date(byAdding: .day, value: 1, to: today),
                  calendar.isDate(date, inSameDayAs: tomorrow) {
            return "Tomorrow"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE, MMM d"
            return formatter.string(from: date)
        }
    }
}

