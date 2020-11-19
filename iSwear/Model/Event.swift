//
//  Event.swift
//  iSwear
//
//  Created by Leo on 11/15/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import Foundation

struct Annotation: Hashable, Codable {
    let message: String
    /// Image data
    let image: Data
}

struct Event: Identifiable, Codable {
    var id = UUID()

    var title = ""
    var description = ""

    /// Now
    var startDate = Date()
    /// Tomorrow
    var endDate = Date(timeIntervalSinceNow: 60 * 60 * 24 + 1)
    /// Only using hh:mm:ss
    var remindTime = Date()
    /// Seconds
    var interval: Double = 60 * 60 * 24

    var isCompleted = false
    var failureCount = 0

    /// How many times you allow yourself to fail
    var toleranceCount = 0

    /// Blame your failed attempt with an `Annotation`
    var blame: Annotation?
    /// Praise your successful attempt with an `Annotation`
    var priase: Annotation?

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
            lhs.endDate == rhs.endDate &&
            lhs.remindTime == rhs.remindTime &&
            lhs.toleranceCount == rhs.toleranceCount
    }
}

enum FileError: Error {
    case invalidURL
}

enum ArrayError: Error {
    case objectNotFound
}

class EventStore: ObservableObject {
    @Published var events: [Event]

    private func fileURL() throws -> URL {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileError.invalidURL
        }
        return dir.appendingPathComponent("events.json")
    }

    func save() throws {
        let url = try fileURL()
        let data = try JSONEncoder().encode(events)
        try data.write(to: url)
        print("Wrote \(data.count) bytes to \(url)")
    }

    func load() throws {
        let url = try fileURL()
        let data = try Data(contentsOf: url)
        events = try JSONDecoder().decode([Event].self, from: data)
    }

    func update(event: Event) throws {
        let i = try index(event: event)
        events[i] = event
    }

    func remove(event: Event) throws {
        let i = try index(event: event)
        events.remove(at: i)
    }

    func ongoingEvents() -> [Event] {
        events.filter { !$0.isCompleted }
    }

    func successEvents() -> [Event] {
        events.filter { $0.isCompleted && $0.failureCount <= $0.toleranceCount }
    }

    func failureEvents() -> [Event] {
        events.filter { $0.isCompleted && $0.failureCount > $0.toleranceCount }
    }

    private func index(event: Event) throws -> Int {
        var i: Int?
        events.forEach { e in
            if e.id == event.id {
                i = events.firstIndex(of: e)
            }
        }
        guard let index = i else {
            print("index not found")
            throw ArrayError.objectNotFound
        }
        return index
    }

    init() {
        events = [Event]()
        do {
            try load()
        } catch let error {
            print("WARNING failed to load events: \(error)")
        }
    }
}
