//
//  SectionText.swift
//  tvOS
//
//  Created by Rasmus Krämer on 05.06.22.
//

import SwiftUI

struct SectionText: View {
    public var title: String
    public var subtitle: String?
    public let leadingPadding: CGFloat
    
    public var visible = true
    public var increaseOfset = false
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color.white)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor.lightGray))
                }
            }
            Spacer()
        }
        .padding(.leading, leadingPadding)
        .padding(.bottom, subtitle == nil ? 0 : 20)
        
        .animation(.linear(duration: HomeConstants.imageTransitionDurarion), value: increaseOfset)
        .offset(x: 0, y: increaseOfset ? 20 : 35)
    }
}
