//
//  Home.swift
//  tvOS
//
//  Created by Rasmus Krämer on 23.05.22.
//

import SwiftUI

struct Home: View {
    enum Section: Hashable {
        case hero
        case content
    }
    
    @FocusState private var focusedSection: Section?
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                ScrollViewReader { scrollView in
                    HomeFullscreenRow(insetPadding: geo.safeAreaInsets, showHeroImage: focusedSection == .hero || focusedSection == nil, focusChanged: { focused in
                        if focused != nil {
                            withAnimation(.easeInOut) {
                                scrollView.scrollTo(Section.hero, anchor: .center)
                            }
                        }
                    })
                        .ignoresSafeArea()
                        .id(Section.hero)
                        .focused($focusedSection, equals: .hero)
                        .focusSection()
                    
                    HomeContent()
                        .id(Section.content)
                        .focused($focusedSection, equals: .content)
                        .focusSection()
                    
                    .onChange(of: focusedSection) { focused in
                        withAnimation(.easeInOut) {
                            if focused == Section.hero {
                                scrollView.scrollTo(Section.hero, anchor: .center)
                            } else if focused == Section.content {
                                scrollView.scrollTo(Section.content, anchor: .topLeading)
                            }
                        }
                    }
                }
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
