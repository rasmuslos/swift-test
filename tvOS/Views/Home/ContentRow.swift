//
//  ContentRow.swift
//  tvOS
//
//  Created by Rasmus Krämer on 25.05.22.
//

import SwiftUI

enum Column: CGFloat {
    case four = 410
    case five = 320
}

struct ContentRow: View {
    public let size: Column
    public let edgeInsets: EdgeInsets
    public let focusPrefix: String
    public let focusedImage: FocusState<String?>.Binding
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 40) {
                ForEach((0...100), id: \.self) {
                    Image("\($0 % 8)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: size.rawValue)
                        .cornerRadius(7.5)
                        .clipped()
                    
                        .focusable()
                        .focused(focusedImage, equals: "\(focusPrefix)::\($0)")
                        .scaleEffect(focusedImage.wrappedValue == "\(focusPrefix)::\($0)" ? 1.1 : 1, anchor: .bottom)
                        .animation(.easeInOut(duration: HomeConstants.imageTransitionDurarion), value: focusedImage.wrappedValue == "\(focusPrefix)::\($0)")
                }
            }
            .padding(.leading, edgeInsets.leading)
            .padding(.trailing, edgeInsets.trailing)
        }
        .frame(height: size.rawValue * 0.7)
    }
}
