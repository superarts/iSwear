//
//  EventTabView.swift
//  iSwear
//
//  Created by Leo on 11/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

struct EventTabView: View {
    @EnvironmentObject private var eventStore: EventStore
    @Environment(\.presentationMode) private var presentation
    @State private var presentingNewEvent = false
//    @State private var selection = 0

    private func tab(events: [Event], emptyString: String) -> AnyView {
        if events.count == 0 {
            return AnyView(Text(emptyString))
        } else {
            return AnyView(List {
                ForEach(events, id: \.self) { event in
                    NavigationLink(
                        destination: EditEventView(
                            event: event
                        ).environmentObject(self.eventStore)
                    ) {
                        EventCell(event: event)
                    }.isDetailLink(false)
                }
            })
        }
    }

//    private func title(selection: Int) -> String {
//        switch selection {
//        case 0: return "Current"
//        case 1: return "Finished"
//        case 2: return "Failed"
//        default: return "WARNING"
//        }
//    }

    var body: some View {
        NavigationView {
//            TabView(selection: $selection) { }
            TabView {
                tab(
                    events: eventStore.ongoingEvents(),
                    emptyString: "Tap \"Create\" to start"
                ).onAppear {
                    //UITableView.appearance().separatorColor = .clear
                }.tabItem {
                    Image(systemName: "phone.fill")
                    Text("Current")
                }

                tab(
                    events: eventStore.successEvents(),
                    emptyString: "You have no completed events yet.\nKeep going!"
                ).onAppear {
                    //UITableView.appearance().separatorColor = .clear
                }.tabItem {
                    Image(systemName: "star.fill")
                    Text("Finished")
                }

                tab(
                    events: eventStore.failureEvents(),
                    emptyString: "You have no failed events. Good job!"
                ).onAppear {
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
                Text("Events"), displayMode: .large
            )
        }
    }
}

struct EventTabView_Previews: PreviewProvider {
    static var previews: some View {
        EventTabView()
    }
}
