//
//  Template.swift
//  iSwear
//
//  Created by Leo on 11/18/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import Foundation

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
