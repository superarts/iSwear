//
//  TextFieldCell.swift
//  iSwear
//
//  Created by Leo on 11/15/20.
//  Copyright © 2020 Super Art Software. All rights reserved.
//

import SwiftUI

struct TextFieldCell: View {
    @State var text: String = ""
    let title: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            TextField(
                title.lowercased(), text: self.$text
            )
            HorizontalLine(color: .secondary)
        }.padding()
    }
    init(title: String) {
        self.title = title
    }
}

struct TextFieldCell_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldCell(title: "Hello")
    }
}
