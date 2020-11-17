//
//  Event.swift
//  iSwear
//
//  Created by Leo on 11/15/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import Foundation

//struct Event: Codable, Identifiable, Hashable {
//    let id: Int
//    let name: String
//}

struct Template: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct Annotation: Hashable {
    let message: String
    /// Image data
    let image: Data
}

struct Event: Identifiable {
    var id = UUID()
    var startDate = Date()
    var endDate = Date()
    /// Seconds
    var interval: Double = 60 * 60 * 24
    var title = ""
    var description = ""
    /// How many times you allow yourself to fail
    var toleranceCo = 0

    /// Blame your failed attempt with an `Annotation`
    var blame: Annotation?
    /// Praise your successful attempt with an `Annotation`
    var priase: Annotation?
}

/// Event+UI
extension Event {
    var countText: String {
        get { "Last for \(count) day(s)" }
//        set(s) { assertionFailure() }
    }

    var count: Int {
        return Int(endDate.timeIntervalSince(startDate) / interval)
    }
}

/// Event+Hashable
extension Event: Hashable {
    /// `Hashable` needs to check all properties, otherwise UI may not update
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.startDate == rhs.startDate &&
            lhs.endDate == rhs.endDate
    }
}

class EventStore: ObservableObject {
    @Published var events = [Event]()
}
