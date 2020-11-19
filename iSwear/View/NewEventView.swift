//
//  NewEventView.swift
//  iSwear
//
//  Created by Leo on 11/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

struct NewEventView: View {
    @State var event: Event
    @Binding var isPresenting: Bool

    @EnvironmentObject private var eventStore: EventStore

    var body: some View {
        EventForm(
            event: $event
        ).navigationBarTitle(
            "Create an event"
        ).navigationBarItems(trailing:
            Button("Done") {
                self.eventStore.events.append(self.event)
                try? self.eventStore.save()
                self.isPresenting = false
            }.disabled(!event.isValid)
        )
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView(event: Event(), isPresenting: .constant(true))
    }
}
