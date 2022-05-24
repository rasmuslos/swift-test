//
//  HomeFullscreenRow.swift
//  tvOS
//
//  Created by Rasmus Krämer on 23.05.22.
//

import SwiftUI

struct HomeFullscreenRow: View {
    public var insetPadding: EdgeInsets
    public var showHeroImage: Bool
    public let focusChanged: (Int?) -> Void
    
    @FocusState private var focusedImage: Int?
    
    @State private var enlargedImage: Int = 0
    @State private var fadeOut = false
    
    let imageChangeDelay = 0.2
    let imageTransitionDurarion = 0.25
    
    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient
                .linearGradient(
                    Gradient(colors: [.secondary, .secondary.opacity(0)]),
                    startPoint: .bottom,
                    endPoint: .center)
            
            Image("\(enlargedImage)")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            
                .opacity(showHeroImage ? fadeOut ? 0 : 1 : 0)
                .animation(.easeInOut(duration: imageTransitionDurarion), value: fadeOut)
                .onChange(of: focusedImage ?? 0) { index in
                    DispatchQueue.main.asyncAfter(deadline: .now() + imageChangeDelay) {
                        if index == focusedImage {
                            self.fadeOut = true
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + imageChangeDelay + imageTransitionDurarion) {
                        withAnimation {
                            if index == focusedImage {
                                self.enlargedImage = index
                            }
                            self.fadeOut = false
                        }
                    }
            }
            
            LinearGradient
                .linearGradient(
                    Gradient(colors: [.black.opacity(showHeroImage ? 0.75 : 0), .black.opacity(0)]),
                    startPoint: .bottom,
                    endPoint: .center)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 40) {
                    ForEach((0...100), id: \.self) {
                        Image("\($0 % 8)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 320)
                            .cornerRadius(7.5)
                            .clipped()
                        
                            .focusable()
                            .focused($focusedImage, equals: $0)
                            .scaleEffect(focusedImage == $0 ? 1.1 : 1)
                            .animation(.easeInOut(duration: imageTransitionDurarion), value: focusedImage == $0)
                    }
                }
                .padding(.leading, insetPadding.leading)
                .padding(.trailing, insetPadding.trailing)
            }
            .padding(.bottom, 40)
            .frame(height: 250, alignment: .leading)
            .onChange(of: focusedImage, perform: focusChanged)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HomeFullscreenRow_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            HomeFullscreenRow(insetPadding: geo.safeAreaInsets, showHeroImage: true, focusChanged: {_ in })
                .ignoresSafeArea()
        }
    }
}
