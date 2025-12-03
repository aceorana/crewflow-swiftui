//
//  Flight.swift
//  CrewFlow
//
//  Created by user278387 on 12/3/25.
//

import Foundation

enum FlightStatus: String {
    case onTime = "On Time"
    case delayed = "Delayed"
    case cancelled = "Cancelled"
}

struct Flight: Identifiable {
    let id = UUID()
    let flightNumber: String
    let origin: String
    let destination: String
    let departureTime: String   // we'll upgrade to Date later
    let status: FlightStatus
}
