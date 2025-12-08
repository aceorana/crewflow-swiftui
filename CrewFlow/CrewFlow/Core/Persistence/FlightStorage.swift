//
//  FlightStorage.swift
//  CrewFlow
//
//  Created by user278387 on 12/7/25.
//

import Foundation

struct FlightStorage {
    private static var fileURL: URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent("flights.json")
    }

    // MARK: - Save flights
    static func save(_ flights: [Flight]) {
        do {
            let data = try JSONEncoder().encode(flights)
            try data.write(to: fileURL, options: [.atomic])
            print("✅ Flights saved")
        } catch {
            print("❌ Error saving flights: \(error)")
        }
    }

    // MARK: - Load flights
    static func load() -> [Flight] {
        do {
            let data = try Data(contentsOf: fileURL)
            let flights = try JSONDecoder().decode([Flight].self, from: data)
            print("📂 Loaded flights from disk (\(flights.count))")
            return flights
        } catch {
            print("ℹ️ No saved flights found — loading sample data")
            return []   // RosterViewModel will detect empty array and use SampleData
        }
    }
}
