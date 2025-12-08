import Foundation

enum SampleData {

    static let upcomingFlights: [Flight] = {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let dayAfterTomorrow = calendar.date(byAdding: .day, value: 2, to: today)!

        // Helper to add hours/minutes to a date for arrivalDate
        func addTime(_ base: Date, hours: Int, minutes: Int) -> Date {
            calendar.date(byAdding: .minute, value: hours * 60 + minutes, to: base) ?? base
        }

        return [
            // Today
            Flight(
                flightNumber: "123",
                origin: "YYC",
                destination: "YVR",
                departureTime: "07:45",
                arrivalTime: "08:25",
                departureDate: today,
                arrivalDate: addTime(today, hours: 1, minutes: 40),
                status: .onTime,
                dutyType: .flight,
                position: "FA1",
                marketingCarrier: "WS",
                notes: "Morning leg to Vancouver."
            ),
            Flight(
                flightNumber: "456",
                origin: "YYC",
                destination: "YYZ",
                departureTime: "09:10",
                arrivalTime: "14:55",
                departureDate: today,
                arrivalDate: addTime(today, hours: 3, minutes: 45),
                status: .delayed,
                dutyType: .flight,
                position: "FA2",
                marketingCarrier: "WS",
                notes: "Longer transcon; slight delay expected."
            ),
            Flight(
                flightNumber: "789",
                origin: "YYC",
                destination: "LAS",
                departureTime: "12:30",
                arrivalTime: "14:45",
                departureDate: today,
                arrivalDate: addTime(today, hours: 2, minutes: 15),
                status: .cancelled,
                dutyType: .flight,
                position: "FA3",
                marketingCarrier: "WS",
                notes: "Cancelled due to operational reasons."
            ),

            // Tomorrow
            Flight(
                flightNumber: "300",
                origin: "YYC",
                destination: "YUL",
                departureTime: "06:15",
                arrivalTime: "11:45",
                departureDate: tomorrow,
                arrivalDate: addTime(tomorrow, hours: 4, minutes: 30),
                status: .onTime,
                dutyType: .flight,
                position: "FA1",
                marketingCarrier: "WS",
                notes: "Early morning departure to Montreal."
            ),
            Flight(
                flightNumber: "301",
                origin: "YUL",
                destination: "YYC",
                departureTime: "13:40",
                arrivalTime: "16:10",
                departureDate: tomorrow,
                arrivalDate: addTime(tomorrow, hours: 4, minutes: 30),
                status: .onTime,
                dutyType: .flight,
                position: "FA2",
                marketingCarrier: "WS",
                notes: "Return leg back to Calgary."
            ),

            // Day after tomorrow
            Flight(
                flightNumber: "900",
                origin: "YYC",
                destination: "OGG",
                departureTime: "08:00",
                arrivalTime: "12:30",
                departureDate: dayAfterTomorrow,
                arrivalDate: addTime(dayAfterTomorrow, hours: 6, minutes: 30),
                status: .onTime,
                dutyType: .flight,
                position: "FA1",
                marketingCarrier: "WS",
                notes: "Hawaii pairing – long duty day."
            )
        ]
    }()  // 👈 important: call the closure
}
