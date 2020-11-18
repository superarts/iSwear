//
//  EventCell.swift
//  iSwear
//
//  Created by Leo on 11/17/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

fileprivate extension Event {
    var rangeDescription: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let start = formatter.string(from: startDate)
        let end = formatter.string(from: endDate)
        return "From \(start) to \(end)"
    }

    var remindDescription: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm aa"
        let remind = formatter.string(from: remindTime)
        return "Remind me at \(remind)"
    }
}

struct EventCell: View {
    let event: Event

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title).foregroundColor(.primary).font(.system(size: 22))
            Text(event.description).foregroundColor(.primary)
            Text(event.rangeDescription)
            Text(event.remindDescription)
            //HorizontalLine(color: .secondary)
        }.padding()
    }
}

struct EventCell_Previews: PreviewProvider {
    static var previews: some View {
        EventCell(event: Event(title: "背单词", description: "一天一百个"))
    }
}
