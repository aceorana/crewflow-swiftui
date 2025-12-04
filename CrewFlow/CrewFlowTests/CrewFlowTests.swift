//
//  CrewFlowTests.swift
//  CrewFlowTests
//
//  Created by user278387 on 12/3/25.
//

import XCTest
@testable import CrewFlow

final class RosterViewModelTests: XCTestCase {

    func test_initialLoad_populatesFlights() {
        let viewModel = RosterViewModel()

        XCTAssertFalse(viewModel.flights.isEmpty, "Expected flights to be loaded on init")
        XCTAssertEqual(viewModel.flights.count, SampleData.todaysFlights.count)
    }
}

