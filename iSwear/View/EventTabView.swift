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
                    ForEach(eventStore.events, id: \.self) { event in
                        EventCell(event: event)
                    }
                }.onAppear {
                    //UITableView.appearance().separatorColor = .clear
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
