//
//  HomeFullscreenRow.swift
//  tvOS
//
//  Created by Rasmus Krämer on 23.05.22.
//

import SwiftUI

struct HomeFullscreenRow: View {
    @FocusState private var focusedImage: Int?
    
    @State private var enlargedImage: Int = 0
    @State private var fadeOut = false
    
    let imageChangeDelay = 0.2
    let imageTransitionDurarion = 0.25
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geo in
                Image("\(enlargedImage)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                
                    .opacity(fadeOut ? 0 : 1)
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
            }
            .ignoresSafeArea()
            
            LinearGradient
                .linearGradient(
                    Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
                    startPoint: .bottom,
                    endPoint: .center)
                .ignoresSafeArea()
            
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
            }
            .frame(height: 250, alignment: .leading)
        }
    }
}

struct HomeFullscreenRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeFullscreenRow()
    }
}
