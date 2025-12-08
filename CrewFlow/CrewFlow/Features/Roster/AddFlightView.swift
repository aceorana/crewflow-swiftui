//
//  AddFlightView.swift
//  CrewFlow
//
//  Created by user278387 on 12/7/25.
//

import SwiftUI

struct AddFlightView: View {
    @ObservedObject var viewModel: RosterViewModel
    @Environment(\.dismiss) private var dismiss

    // Form state
    @State private var flightNumber: String = ""
    @State private var origin: String = ""
    @State private var destination: String = ""

    @State private var departure: Date = Date()
    @State private var arrival: Date = Date().addingTimeInterval(60 * 60)

    @State private var dutyType: DutyType = .flight
    @State private var position: String = "FA1"
    @State private var marketingCarrier: String = "WS"
    @State private var notes: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Route") {
                    TextField("Flight #", text: $flightNumber)
                    TextField("Origin (e.g. YYC)", text: $origin)
                    TextField("Destination (e.g. YVR)", text: $destination)
                }

                Section("Schedule") {
                    DatePicker("Departure", selection: $departure, displayedComponents: [.date, .hourAndMinute])
                    DatePicker("Arrival", selection: $arrival, displayedComponents: [.date, .hourAndMinute])
                }

                Section("Details") {
                    Picker("Duty Type", selection: $dutyType) {
                        ForEach(DutyType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }

                    TextField("Position (e.g. FA1)", text: $position)
                    TextField("Marketing Carrier (e.g. WS)", text: $marketingCarrier)
                    TextField("Notes", text: $notes, axis: .vertical)
                }
            }
            .navigationTitle("Add Duty")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(!isValid)
                }
            }
        }
    }

    private var isValid: Bool {
        !flightNumber.trimmingCharacters(in: .whitespaces).isEmpty &&
        !origin.trimmingCharacters(in: .whitespaces).isEmpty &&
        !destination.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func save() {
        viewModel.addFlight(
            flightNumber: flightNumber.trimmingCharacters(in: .whitespaces),
            origin: origin.trimmingCharacters(in: .whitespaces),
            destination: destination.trimmingCharacters(in: .whitespaces),
            departure: departure,
            arrival: arrival,
            dutyType: dutyType,
            position: position.isEmpty ? nil : position,
            marketingCarrier: marketingCarrier.isEmpty ? nil : marketingCarrier,
            notes: notes.isEmpty ? nil : notes
        )
        dismiss()
    }
}
