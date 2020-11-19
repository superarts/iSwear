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
    @EnvironmentObject var eventStore: EventStore
    @Environment(\.presentationMode) var presentation
    @State var presentingNewEvent = false

    var body: some View {
        NavigationView {
            TabView {
                List {
                    ForEach(eventStore.ongoingEvents(), id: \.self) { event in
                        NavigationLink(
                            destination: EditEventView(
                                event: event
                            ).environmentObject(self.eventStore)
                        ) {
                            EventCell(event: event)
                        }.isDetailLink(false)
                    }
                }.onAppear {
                    //UITableView.appearance().separatorColor = .clear
                }.tabItem {
                    Image(systemName: "phone.fill")
                    Text("Current")
                }

                List {
                    ForEach(eventStore.successEvents(), id: \.self) { event in
                        NavigationLink(
                            destination: EditEventView(
                                event: event
                            ).environmentObject(self.eventStore)
                        ) {
                            EventCell(event: event)
                        }.isDetailLink(false)
                    }
                }.onAppear {
                    //UITableView.appearance().separatorColor = .clear
                }.tabItem {
                    Image(systemName: "star.fill")
                    Text("Finished")
                }

                List {
                    ForEach(eventStore.failureEvents(), id: \.self) { event in
                        NavigationLink(
                            destination: EditEventView(
                                event: event
                            ).environmentObject(self.eventStore)
                        ) {
                            EventCell(event: event)
                        }.isDetailLink(false)
                    }
                }.onAppear {
                    //UITableView.appearance().separatorColor = .clear
                }.tabItem {
                    Image(systemName: "tv.fill")
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
