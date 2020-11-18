//
//  NewEventView.swift
//  iSwear
//
//  Created by Leo on 11/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

/// Event+NewEventView
fileprivate extension Event {
    var countText: String {
        "Last for \(count) day(s)"
    }

    var countTextColor: Color {
        count > 0 ? .secondary : .red
    }

    var isValid: Bool {
        !title.isEmpty && !description.isEmpty && count > 0
    }
}

struct NewEventView: View {
    @State var event: Event
    @Binding var isPresenting: Bool

    @EnvironmentObject private var eventStore: EventStore
    @State private var selection: Template?

    var body: some View {
        Form {
            Section(header: Text("CONTENTS")) {
                TextField("Title", text: $event.title)
                TextField("Description", text: $event.description)
            }

            Section(
                header: Text("DURATION"),
                footer: Text(event.countText).foregroundColor(event.countTextColor)
            ) {
                DatePicker(
                    "Starts from",
                    selection: $event.startDate,
                    in: Date() ... Date.distantFuture,
                    displayedComponents: [.date]
                )
                DatePicker(
                    "Until",
                    selection: $event.endDate,
                    in: event.startDate ... Date.distantFuture,
                    displayedComponents: [.date]
                ) //.datePickerStyle(GraphicalDatePickerStyle()) <- iOS 14.0+
            }

            Section(
                header: Text("REMINDER")
            ) {
                DatePicker(
                    "Remind me at",
                    selection: $event.remindTime,
                    displayedComponents: [.hourAndMinute]
                )
            }

        }.onAppear {
            //UITableView.appearance().separatorColor = .separator
        }.navigationBarItems(trailing:
            Button("Done") {
                self.eventStore.events.append(self.event)
                try? self.eventStore.save()
                self.isPresenting = false
            }.disabled(!event.isValid)
        ).navigationBarTitle("Create an event")
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView(event: Event(), isPresenting: .constant(true))
    }
}
