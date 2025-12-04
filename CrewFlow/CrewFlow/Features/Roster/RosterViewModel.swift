//
//  RosterViewModel.swift
//  CrewFlow
//
//  Created by user278387 on 12/4/25.
//

import Foundation
import Combine

final class RosterViewModel: ObservableObject {

    // In a real app this would come from a service
    @Published private(set) var flights: [Flight] = []

    init() {
        loadTodaysFlights()
    }

    func loadTodaysFlights() {
        // For now just use sample data
        flights = SampleData.todaysFlights
    }
}
