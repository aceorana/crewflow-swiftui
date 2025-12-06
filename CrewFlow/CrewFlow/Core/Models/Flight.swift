import Foundation

enum FlightStatus: String, Codable { //making this and Flight codable so we can easily load from JSON data if we need to later
    case onTime = "On Time"
    case delayed = "Delayed"
    case cancelled = "Cancelled"
}

struct Flight: Identifiable, Codable {
    let id: UUID
    let flightNumber: String
    let origin: String
    let destination: String
    let departureTime: String      // keep as String for now
    let departureDate: Date        // NEW: used for grouping by day
    let status: FlightStatus

    init(
        id: UUID = UUID(),
        flightNumber: String,
        origin: String,
        destination: String,
        departureTime: String,
        departureDate: Date,
        status: FlightStatus
    ) {
        self.id = id
        self.flightNumber = flightNumber
        self.origin = origin
        self.destination = destination
        self.departureTime = departureTime
        self.departureDate = departureDate
        self.status = status
    }
}
