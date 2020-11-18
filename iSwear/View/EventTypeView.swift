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

    private let templates = TemplateStore().templates
    @State private var selection: Template?
//    @State var action: Int?

    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(templates, id: \.self) { template in
//                    Text(template.name)
                    NavigationLink(
                        destination: NewEventView(
                            event: template.event,
                            isPresenting: self.$isPresenting
                        ).environmentObject(self.eventStore)
//                        tag: 0,
//                        selection: self.$action
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
