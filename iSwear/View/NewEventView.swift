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
//    @State private var start = Date()

//    @State private var events: [Event] = [
//        Event(id: 0, name: "From TODAY I swear..."),
//        Event(id: 1, name: "Every X day(s)..."),
//        Event(id: 2, name: "By Y:00 PM..."),
//        Event(id: 3, name: "I'll finish ZZZ."),
//        Event(id: 4, name: "Otherwise I'll be shamed by this PIC of mine!"),
//    ]
    @State private var selection: Template?
//    @State var action: Int?
    //@State var footerText: String

//    func footerText() -> String {
//        event.countText
//    }
//
//    func footerColor() -> Color {
//        event.count > 0 ? .secondary : .red
//    }

    var body: some View {
//        List(selection: $selection) {
        Form {
            Section(header: Text("CONTENTS")) {
                TextField("Title", text: $event.title)
                TextField("Description", text: $event.description)
//                Toggle(isOn: $isPrivate) {
//                    Text("Private Account")
//                }
            }

//            DatePickerCell(title: "Starts from")
//            DatePickerCell(title: "Until")
            Section(
                header: Text("DURATION"),
                footer: Text(event.countText).foregroundColor(event.countTextColor)
                //footer: Text(event.countText) //.foregroundColor(self.footerColor())
                //footer: Text(event.countText).foregroundColor(self.footerColor())
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
//                    in: Date() ... Date.distantFuture,
                    displayedComponents: [.hourAndMinute]
                )
            }

//            ForEach(events, id: \.self) { event in
//                Button (action: {
//                    self.eventStore.events.append(Event(id: 0, name: event.name))
//                } ) {
//                    Text(event.name)
//                }
//            }
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
