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
    //@Binding var parentIsActive: Bool

    @State private var events: [Event] = [
        Event(id: 0, name: "From TODAY I swear..."),
        Event(id: 1, name: "Every X day(s)..."),
        Event(id: 2, name: "By Y:00 PM..."),
        Event(id: 3, name: "I'll finish ZZZ."),
        Event(id: 4, name: "Otherwise I'll be shamed by this PIC of mine!"),
    ]
    @State private var selection: Template?
    @State var action: Int?

    var body: some View {
        List(selection: $selection) {
            ForEach(events, id: \.self) { event in
                Button (action: {
                    self.eventStore.events.append(Event(id: 0, name: event.name))
                    //self.isPresenting = false

                    //print(self.parentIsActive)
                    //self.parentIsActive = false
                    //(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootToEventTabView()
                    //print(self.parentIsActive)
                } ) {
                    Text(event.name)
                }
                /*
                NavigationLink(
                    destination: VStack {
                        self.parentIsActive = false
                    }.frame(maxWidth: .infinity, maxHeight: .infinity),
                    tag: event.id,
                    selection: self.$action
                ) {
                    VStack {
                        Text(event.name)
                    }
                }
                 */
            }
        }.navigationBarItems(trailing:
            Button("Done") {
                self.isPresenting = false
            }
            /*
            NavigationLink(
                destination: EventTypeView(parentIsActive: self.$isActive),
                isActive: self.$isActive
            ) {
                Text("Create")
            }.isDetailLink(false)
            */
        ).navigationBarTitle("Create an event")
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView(isPresenting: .constant(true))
    }
}
