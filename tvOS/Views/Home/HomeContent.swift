//
//  HomeContent.swift
//  tvOS
//
//  Created by Rasmus Krämer on 24.05.22.
//

import SwiftUI

struct HomeContent: View {
    @FocusState private var focusedText: String?
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                ForEach((0...30), id: \.self) { rowId in
                    LazyHStack {
                        ForEach((0...10), id: \.self) {
                            Text("\($0)")
                                .focusable()
                                .id("\($0)\(rowId)")
                                .focused($focusedText, equals: "\($0)\(rowId)")
                                .foregroundColor(focusedText == "\($0)\(rowId)" ? Color.red : Color.white)
                        }
                    }
                }
            }
        }
    }
}

struct HomeContent_Previews: PreviewProvider {
    static var previews: some View {
        HomeContent()
    }
}
