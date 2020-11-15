//
//  Event.swift
//  iSwear
//
//  Created by Leo on 11/15/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import Foundation

struct Event: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct Template: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct Annotation {
    let message: String
    /// Image data
    let image: Data
}

struct Rule {
    let startDate: Date
    let endDate: Date
    /// Seconds
    let interval: Double
    let title: String
    let description: String
    /// How many times you allow yourself to fail
    let toleranceCount: Int

    /// Blame your failed attempt with an `Annotation`
    let blame: Annotation
    /// Praise your successful attempt with an `Annotation`
    let priase: Annotation

    var count: Int {
        return Int(endDate.timeIntervalSince(startDate) / interval)
    }
}

class EventStore: ObservableObject {
    @Published var events = [Event]()
}
