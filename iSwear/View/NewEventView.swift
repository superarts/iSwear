//
//  NewEventView.swift
//  iSwear
//
//  Created by Leo on 11/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

struct NewEventView: View {
    @Binding var isPresenting: Bool
    @EnvironmentObject var eventStore: EventStore
//    @State private var start = Date()
    @State private var event = Event()

//    @State private var events: [Event] = [
//        Event(id: 0, name: "From TODAY I swear..."),
//        Event(id: 1, name: "Every X day(s)..."),
//        Event(id: 2, name: "By Y:00 PM..."),
//        Event(id: 3, name: "I'll finish ZZZ."),
//        Event(id: 4, name: "Otherwise I'll be shamed by this PIC of mine!"),
//    ]
    @State private var selection: Template?
    @State var action: Int?

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
            Section(header: Text("DURATION"), footer: Text(event.countText)) {
                DatePicker("Starts from", selection: $event.startDate)
                DatePicker("Until", selection: $event.endDate)
            }

//            ForEach(events, id: \.self) { event in
//                Button (action: {
//                    self.eventStore.events.append(Event(id: 0, name: event.name))
//                } ) {
//                    Text(event.name)
//                }
//            }
        }.navigationBarItems(trailing:
            Button("Done") {
                self.eventStore.events.append(self.event)
                self.isPresenting = false
            }
        ).navigationBarTitle("Create an event")
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView(isPresenting: .constant(true))
    }
}
