//
//  SampleData.swift
//  CrewFlow
//
//  Created by user278387 on 12/3/25.
//

import Foundation

struct SampleData {
    static let todaysFlights: [Flight] = [
        Flight(
            flightNumber: "WS 123",
            origin: "YYC",
            destination: "YVR",
            departureTime: "07:45",
            status: .onTime
        ),
        Flight(
            flightNumber: "WS 456",
            origin: "YYC",
            destination: "YYZ",
            departureTime: "09:10",
            status: .delayed
        ),
        Flight(
            flightNumber: "WS 789",
            origin: "YYC",
            destination: "LAS",
            departureTime: "12:30",
            status: .cancelled
        )
    ]
}
