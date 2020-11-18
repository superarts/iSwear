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

/// Event template
struct Template: Codable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    /// Sample event
    let event: Event
}

struct TemplateStore {
    let templates: [Template]
    init() {
        templates = [
            Template(
                name: "吐血背单词",
                event: Event(
                    title: "背单词",
                    description: "老子拼了，每天一百个，坚持一百天我就十级毕业",
                    endDate: Date(timeIntervalSinceNow: 60 * 60 * 24 * 100 + 1),
                    remindTime: Date()
                )
            ),
            Template(
                name: "每天晨跑",
                event: Event(
                    title: "晨跑",
                    description: "起床之后第一件事就是跑跑跑",
                    endDate: Date(timeIntervalSinceNow: 60 * 60 * 24 * 100 + 1),
                    remindTime: Date()
                )
            ),
        ]
    }
}

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

class EventStore: ObservableObject {
    @Published var events: [Event]

    func fileURL() throws -> URL {
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

    init() {
        events = [Event]()
        do {
            try load()
        } catch let error {
            print("WARNING failed to load events: \(error)")
        }
    }
}
