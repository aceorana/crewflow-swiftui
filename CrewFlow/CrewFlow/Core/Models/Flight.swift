import Foundation

enum FlightStatus: String, Codable {
    case onTime = "On Time"
    case delayed = "Delayed"
    case cancelled = "Cancelled"
}

enum DutyType: String, Codable, CaseIterable {
    case flight = "Flight"
    case ground = "Ground"
    case layover = "Layover"
    case other = "Other"
}

struct Flight: Identifiable, Codable, Hashable {
    let id: UUID
    let flightNumber: String

    // Core travel info
    let origin: String
    let destination: String
    let departureTime: String      // keep as String for now
    let arrivalTime: String        // NEW
    let departureDate: Date
    let arrivalDate: Date          // NEW

    // Operational info
    let status: FlightStatus
    let dutyType: DutyType         // NEW: for filtering
    let position: String?          // NEW: FA1, FA2, etc.
    let marketingCarrier: String?  // NEW: WS, QK
    let notes: String?             // NEW: extra info

    init(
        id: UUID = UUID(),
        flightNumber: String,
        origin: String,
        destination: String,
        departureTime: String,
        arrivalTime: String,
        departureDate: Date,
        arrivalDate: Date,
        status: FlightStatus,
        dutyType: DutyType,
        position: String? = nil,
        marketingCarrier: String? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.flightNumber = flightNumber
        self.origin = origin
        self.destination = destination
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.departureDate = departureDate
        self.arrivalDate = arrivalDate
        self.status = status
        self.dutyType = dutyType
        self.position = position
        self.marketingCarrier = marketingCarrier
        self.notes = notes
    }
}
