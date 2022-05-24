//
//  Home.swift
//  tvOS
//
//  Created by Rasmus Krämer on 23.05.22.
//

import SwiftUI

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
    
    @State private var enlargedImage: Int = 0
    @State private var showHeroImage = true
    @State private var fadeOut = false
    @State private var heroWasFocused = true
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                ScrollViewReader { scrollView in
                    ZStack {}
                    .frame(height: geo.size.height - 120)
                    .focusable(false)
                    .id(Section.spacer)
                    
                    // Hero section
                    HStack {
                        Text("Next up")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.leading, geo.safeAreaInsets.leading)
                    .padding(.bottom, -20)
                    
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
                                    .focused($focusedImage, equals: "hero-\($0)")
                                    .scaleEffect(focusedImage == "hero-\($0)" ? 1.1 : 1)
                                    .animation(.easeInOut(duration: imageTransitionDurarion), value: focusedImage == "hero-\($0)")
                            }
                        }
                        .padding(.leading, geo.safeAreaInsets.leading)
                        .padding(.trailing, geo.safeAreaInsets.trailing)
                    }
                    .frame(height: 200)
                    .id(Section.hero)
                    .focused($focusedSection, equals: .hero)
                    .focusSection()
                    
                    // Content section
                    ForEach((0...15), id: \.self) { section in
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
                                        .focused($focusedImage, equals: "\(section)-\($0)")
                                        .scaleEffect(focusedImage == "\(section)-\($0)" ? 1.1 : 1)
                                        .animation(.easeInOut(duration: imageTransitionDurarion), value: focusedImage == "\(section)-\($0)")
                                }
                            }
                            .padding(.leading, geo.safeAreaInsets.leading)
                            .padding(.trailing, geo.safeAreaInsets.trailing)
                        }
                        
                    }
                    .frame(height: 200)
                    .id(Section.content)
                    .focused($focusedSection, equals: .content)
                    .focusSection()
                    
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
                }
            }
            .background {
                ZStack(alignment: .bottom) {
                    Image("\(enlargedImage)")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                    
                        .opacity(showHeroImage ? fadeOut ? 0 : 1 : 0)
                        .animation(.easeInOut(duration: imageTransitionDurarion), value: fadeOut)
                        .onChange(of: focusedImage) { index in
                            guard let index = index else {
                                return
                            }
                            
                            let heroWasVisible = self.showHeroImage
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.showHeroImage = index.starts(with: "hero-")
                            }
                            
                            if !heroWasVisible && self.showHeroImage {
                                self.fadeOut = true
                                self.enlargedImage = Int(index.replacingOccurrences(of: "hero-", with: "")) ?? 0
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + imageChangeDelay) {
                                    if index == focusedImage {
                                        self.fadeOut = false
                                    }
                                }
                                
                                return
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + imageChangeDelay) {
                                if index == focusedImage && showHeroImage {
                                    self.fadeOut = true
                                }
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + imageChangeDelay + imageTransitionDurarion) {
                                withAnimation {
                                    if index == focusedImage {
                                        guard let image = Int(index.replacingOccurrences(of: "hero-", with: "")) else {
                                            return
                                        }
                                        
                                        self.enlargedImage = image
                                    }
                                    self.fadeOut = false
                                }
                            }
                        }
                }
                
                LinearGradient
                    .linearGradient(
                        Gradient(colors: [.black.opacity(0.75), .black.opacity(0)]),
                        startPoint: .bottom,
                        endPoint: .center)
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
