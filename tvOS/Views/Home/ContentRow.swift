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
    
    @State private var containerHeight = CGFloat.zero
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 40) {
                    ForEach((0...100), id: \.self) {
                        let id = $0 % 8
                        
                        Image("\(id)")
                            .resizable()
                            .aspectRatio(16 / 9, contentMode: .fit)
                            .scaledToFit()
                            .cornerRadius(7.5)
                            .frame(width: size.rawValue)
                            .clipped()
                        
                            .focusable()
                            .focused(focusedImage, equals: "\(focusPrefix)::\(id)")
                            .scaleEffect(focusedImage.wrappedValue == "\(focusPrefix)::\(id)" ? 1.11 : 1, anchor: size == .five ? .bottom : .center)
                            .animation(.easeInOut(duration: HomeConstants.imageTransitionDurarion), value: focusedImage.wrappedValue == "\(focusPrefix)::\(id)")
                    }
                }
                .frame(height: (size.rawValue / (16 / 9)) * (focusPrefix == "hero" ? 1.22 : 1.1))
                .padding(.leading, edgeInsets.leading)
                .padding(.trailing, edgeInsets.trailing)
            }
        }
    }
}
