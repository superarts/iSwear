//
//  EditEventView.swift
//  iSwear
//
//  Created by Leo on 11/18/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

struct EditEventView: View {
    @State var event: Event

    @EnvironmentObject private var eventStore: EventStore
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false

    var body: some View {
        VStack {
            EventForm(
                event: $event
            ).navigationBarTitle(
                "Edit event"
            ).navigationBarItems(trailing:
                Button("Update") {
                    do {
                        try self.eventStore.update(event: self.event)
                        try self.eventStore.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        self.showingAlert = true
                    }
                }.disabled(
                    !event.isValid
                ).alert(isPresented: $showingAlert) {
                    Alert(title: Text("Update Failed"), message: Text("Please try again later"), dismissButton: .default(Text("OK")))
                }
            )

            Button("Mark as done") {
                var e = self.event
                e.isCompleted = true
                try? self.eventStore.update(event: e)
                try? self.eventStore.save()
                self.presentationMode.wrappedValue.dismiss()
            }.padding()

            Button("Mark as failed") {
                var e = self.event
                e.isCompleted = true
                e.isCompleted = true
                e.failureCount = e.toleranceCount + 1
                try? self.eventStore.update(event: e)
                try? self.eventStore.save()
                self.presentationMode.wrappedValue.dismiss()
            }.padding()

            Button("Delete") {
                try? self.eventStore.remove(event: self.event)
                try? self.eventStore.save()
                self.presentationMode.wrappedValue.dismiss()
            }.padding(
            ).foregroundColor(.red)
        }
    }
}

struct EditEventView_Previews: PreviewProvider {
    static var previews: some View {
        EditEventView(event: Event())
    }
}
