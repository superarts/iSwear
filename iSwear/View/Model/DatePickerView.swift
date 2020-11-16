//
//  DatePickerView.swift
//  iSwear
//
//  Created by Leo on 11/15/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

struct DatePickerView: View {
    @State var date = Date()
    var body: some View {
        Form {
            DatePicker(selection: $date, label: { Text("test") })
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
