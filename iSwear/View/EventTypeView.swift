//
//  ContentView.swift
//  iSwear
//
//  Created by Leo on 11/1/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

struct EventTypeView: View {
    @Binding var isPresenting: Bool
    @EnvironmentObject var eventStore: EventStore
    //@Binding var parentIsActive: Bool

    @State private var templates: [Template] = [
        Template(id: 0, name: "Daily small achievement"),
        Template(id: 1, name: "Weekly huge achievement"),
        Template(id: 2, name: "Custom"),
    ]
    @State private var selection: Template?
    @State var action: Int?

    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(templates, id: \.self) { template in
                    NavigationLink(
                        destination: NewEventView(
                            isPresenting: self.$isPresenting
                        ).environmentObject(self.eventStore),
                        tag: template.id,
                        selection: self.$action
                    ) {
                        VStack {
                            Text(template.name)
                        }
                    }.isDetailLink(false)
                }
            }.navigationBarTitle(
                "Choose a template"
            ).navigationBarItems(leading:
                Button("Close") {
                    self.isPresenting = false
                }
            )
        }
    }
}

struct EventTypeView_Previews: PreviewProvider {
    static var previews: some View {
        EventTypeView(isPresenting: .constant(true))
    }
}
