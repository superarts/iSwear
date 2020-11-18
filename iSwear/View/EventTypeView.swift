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

    private let templates = TemplateStore().templates
    @State private var selection: Template?

    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(templates, id: \.self) { template in
                    NavigationLink(
                        destination: NewEventView(
                            event: template.event,
                            isPresenting: self.$isPresenting
                        ).environmentObject(self.eventStore)
                    ) {
                        VStack {
                            Text(template.name)
                        }
                    }.isDetailLink(false)
                }
            }.onAppear {
                //UITableView.appearance().separatorColor = .separator
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
