//
//  Home.swift
//  tvOS
//
//  Created by Rasmus Krämer on 23.05.22.
//

import SwiftUI

public struct HomeConstants {
    public static let imageChangeDelay = 0.4
    public static let imageTransitionDurarion = 0.25
}
private enum Section: Hashable {
    case spacer
    case hero
    case content
}

struct Home: View {
    @FocusState private var focusedSection: Section?
    @FocusState private var focusedImage: String?
    
    @State private var heroWasFocused: Bool = false
    
    @State private var enlargedImage: String = "0"
    @State private var frozenImage: String?
    @State private var heroVisible = true
    @State private var hideImage = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                ScrollViewReader { scrollView in
                    // Hero section
                    Spacer(minLength: UIScreen.main.bounds.height - ((Column.five.rawValue / (16 / 9)) * 1.11 + 150))
                        .id(Section.spacer)
                    
                    VStack {
                        SectionText(title: "Next up", leadingPadding: geo.safeAreaInsets.leading, visible: !heroVisible, increaseOfset: focusedImage?.starts(with: "hero") ?? false)
                        ContentRow(size: .five, edgeInsets: geo.safeAreaInsets, focusPrefix: "hero", focusedImage: $focusedImage)
                    }
                    .id(Section.hero)
                    .focused($focusedSection, equals: .hero)
                    .focusSection()
                    
                    // Content section
                    ForEach((0...15), id: \.self) { section in
                        if section != 0 {
                            SectionText(title: "Section \(section)", subtitle: "This is a cool section", leadingPadding: geo.safeAreaInsets.leading, visible: !heroVisible, increaseOfset: focusedImage?.starts(with: "\(section)") ?? false)
                        }
                        ContentRow(size: .four, edgeInsets: geo.safeAreaInsets, focusPrefix: "\(section)", focusedImage: $focusedImage)
                    }
                    .id(Section.content)
                    .focused($focusedSection, equals: .content)
                    .focusSection()
                    
                    .onChange(of: focusedImage) { image in
                        guard let image = image else {
                            return
                        }
                        guard let id: String = {
                            let parts = image.components(separatedBy: "::")
                            if parts.count != 2 {
                                return nil
                            }
                            
                            return parts[1]
                        }() else {
                            return
                        }
                        
                        if image.starts(with: "hero") {
                            if heroWasFocused {
                                scrollView.scrollTo(Section.spacer, anchor: .top)
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + HomeConstants.imageChangeDelay) {
                                if focusedImage != image {
                                    return
                                }
                                frozenImage = id
                                hideImage = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + HomeConstants.imageTransitionDurarion) {
                                    enlargedImage = id
                                    hideImage = false
                                }
                            }
                        }
                    }
                    .onChange(of: focusedSection) { section in
                        guard let focusedSection = focusedSection else {
                            return
                        }
                        let focusedHero = focusedSection == .hero
                        
                        withAnimation(.easeInOut(duration: HomeConstants.imageTransitionDurarion)) {
                            scrollView.scrollTo(focusedHero ? Section.spacer : Section.hero, anchor: focusedHero ? .top : .bottom)
                            heroVisible = focusedHero
                        }
                        heroWasFocused = focusedHero
                    }
                }
            }
            .background {
                ZStack(alignment: .bottom) {
                    if let frozenImage = frozenImage {
                        BackgroundImage(url: frozenImage)
                            .opacity(heroVisible ? 1 : 0)
                    }
                    BackgroundImage(url: enlargedImage)
                        .opacity(!heroVisible || hideImage ? 0 : 1)
                        .animation(.easeInOut(duration: HomeConstants.imageTransitionDurarion), value: hideImage)
                    
                    LinearGradient
                        .linearGradient(
                            Gradient(colors: [.black.opacity(0.75), .black.opacity(0)]),
                            startPoint: .bottom,
                            endPoint: .center)
                }
            }
            .ignoresSafeArea()
        }
    }
}
