//
//  Home.swift
//  tvOS
//
//  Created by Rasmus Krämer on 23.05.22.
//

import SwiftUI

public struct HomeConstants {
    public static let imageChangeDelay = 0.2
    public static let imageTransitionDurarion = 0.25
}

fileprivate struct BackgroundImage: View {
    public let url: String
    
    var body: some View {
        Image(url)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
}

struct Home: View {
    enum Section: Hashable {
        case spacer
        case hero
        case content
    }
    
    let imageChangeDelay = 0.2
    let imageTransitionDurarion = 0.25
    
    @FocusState private var focusedSection: Section?
    @FocusState private var focusedImage: String?
    
    @State private var enlargedImage: String?
    @State private var frozenImage: String?
    @State private var heroVisible = true
    @State private var hideImage = true
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                ScrollViewReader { scrollView in
                    ZStack {}
                        .frame(height: geo.size.height - geo.safeAreaInsets.top)
                        .focusable(false)
                        .id(Section.spacer)
                    
                    VStack {
                        // Hero section
                        HStack {
                            Text("Next up")
                                .font(.headline)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding(.leading, geo.safeAreaInsets.leading)
                        .padding(.bottom, -20)
                        
                        ContentRow(size: .five, edgeInsets: geo.safeAreaInsets, focusPrefix: "hero", focusedImage: $focusedImage)
                        .id(Section.hero)
                        .focused($focusedSection, equals: .hero)
                        .focusSection()
                    }
                    
                    // Content section
                    ForEach((0...15), id: \.self) { section in
                        ContentRow(size: .four, edgeInsets: geo.safeAreaInsets, focusPrefix: "\(section)", focusedImage: $focusedImage)
                        
                    }
                    .id(Section.content)
                    .focused($focusedSection, equals: .content)
                    .focusSection()
                    
                    /*
                    .onChange(of: focusedImage) { focused in
                        if focused?.starts(with: "hero-") ?? false {
                            if heroWasFocused {
                                scrollView.scrollTo(Section.spacer, anchor: .top)
                            } else {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    scrollView.scrollTo(Section.spacer, anchor: .top)
                                }
                            }
                        }
                    }
                    .onChange(of: focusedSection) { section in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            if heroWasFocused && section == .content {
                                scrollView.scrollTo(Section.hero, anchor: .bottom)
                            }
                            
                            heroWasFocused = section == .hero
                        }
                    }
                     */
                }
            }
            .background {
                /*
                ZStack(alignment: .bottom) {
                    if let frozenImage = frozenImage {
                        BackgroundImage(url: frozenImage)
                    }
                    if let enlargedImage = enlargedImage {
                        BackgroundImage(url: enlargedImage)
                            .opacity(!heroVisible || hideImage ? 0 : 1)
                            .animation(.easeInOut(duration: HomeConstants.imageTransitionDurarion), value: hideImage)
                    }
                    
                    LinearGradient
                        .linearGradient(
                            Gradient(colors: [.black.opacity(0.75), .black.opacity(0)]),
                            startPoint: .bottom,
                            endPoint: .center)
                }
                .onChange(of: $focusedImage) {
                    guard let image = $0 else {
                        self.heroVisible = false
                        return
                    }
                    
                    hideImage = true
                    frozenImage = image
                    _enlargedImage = image
                    
                    heroVisible = true
                }
                 */
            }
            .ignoresSafeArea()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
