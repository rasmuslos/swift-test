//
//  BackgroundImage.swift
//  tvOS
//
//  Created by Rasmus Krämer on 05.06.22.
//

import SwiftUI

struct BackgroundImage: View {
    public let url: String
    
    var body: some View {
        Image(url)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
}
