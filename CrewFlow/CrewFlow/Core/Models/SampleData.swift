//
//  SampleData.swift
//  CrewFlow
//
//  Created by user278387 on 12/3/25.
//

import Foundation

enum SampleData {

    static let upcomingFlights: [Flight] = {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let dayAfterTomorrow = calendar.date(byAdding: .day, value: 2, to: today)!

        return [
            // Today
            Flight(
                flightNumber: "WS 123",
                origin: "YYC",
                destination: "YVR",
                departureTime: "07:45",
                departureDate: today,
                status: .onTime
            ),
            Flight(
                flightNumber: "WS 456",
                origin: "YYC",
                destination: "YYZ",
                departureTime: "09:10",
                departureDate: today,
                status: .delayed
            ),
            Flight(
                flightNumber: "WS 789",
                origin: "YYC",
                destination: "LAS",
                departureTime: "12:30",
                departureDate: today,
                status: .cancelled
            ),

            // Tomorrow
            Flight(
                flightNumber: "WS 300",
                origin: "YYC",
                destination: "YUL",
                departureTime: "06:15",
                departureDate: tomorrow,
                status: .onTime
            ),
            Flight(
                flightNumber: "WS 301",
                origin: "YUL",
                destination: "YYC",
                departureTime: "13:40",
                departureDate: tomorrow,
                status: .onTime
            ),

            // Day after tomorrow
            Flight(
                flightNumber: "WS 900",
                origin: "YYC",
                destination: "OGG",
                departureTime: "08:00",
                departureDate: dayAfterTomorrow,
                status: .onTime
            )
        ]
    }()
}
