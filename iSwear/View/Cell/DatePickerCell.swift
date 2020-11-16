//
//  DatePickerCell.swift
//  iSwear
//
//  Created by Leo on 11/15/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

struct DatePickerCell: View {
    @State var text: String = ""
    let title: String
    @Environment(\.presentationMode) var presentation
    @State var presentingPicker = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            /*
            Button (action: {
                print("picker")
            } ) {
                Text("mm-dd-yyyy")
            }
            */
            Button("Create") {
                self.presentingPicker = true
            }.sheet(isPresented: $presentingPicker) {
                DatePickerView()
//                    isPresenting: self.$presentingNewEvent
//                ).environmentObject(self.eventStore)
            }
            HorizontalLine(color: .secondary)
        }.padding()
    }
    init(title: String) {
        self.title = title
    }
}

struct DatePickerCell_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldCell(title: "Today")
    }
}
