//
//  EventTabView.swift
//  iSwear
//
//  Created by Leo on 11/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

struct EventTabView: View {
    //@State var isActive: Bool = false
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var eventStore: EventStore
    @State var presentingNewEvent = false

    var body: some View {
        NavigationView {
            TabView {
                List {
                    ForEach(eventStore.events, id: \.self) { event in
                        Button (action: {
                            print(self.eventStore.events)
                            print(event)
                            self.eventStore.events.removeAll { $0 == event }
                        } ) {
                            Text(event.name)
                        }
                    }
                }.tabItem {
                        Image(systemName: "phone.fill")
                        Text("Current")
                }
                Text("Successful challenges")
                    .tabItem {
                        Image(systemName: "tv.fill")
                        Text("Finished")
                }
                Text("Failed challenges")
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Failed")
                }
            }.navigationBarItems(trailing:
                Button("Create") {
                    self.presentingNewEvent = true
                }.sheet(isPresented: $presentingNewEvent) {
                    EventTypeView(
                        isPresenting: self.$presentingNewEvent
                    ).environmentObject(self.eventStore)
                }
                /*
                NavigationLink(
                    destination: EventTypeView(parentIsActive: self.$isActive),
                    isActive: self.$isActive
                ) {
                    Text("Create")
                }.isDetailLink(false)
                */
            ).navigationBarTitle(
                Text("Current"), displayMode: .large
            )
        }
    }
}

struct EventTabView_Previews: PreviewProvider {
    static var previews: some View {
        EventTabView()
    }
}
