//
//  LargeButtonStyle.swift
//  tvOS
//
//  Created by Rasmus Krämer on 06.06.22.
//

import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.white)
            .background {
                Color.accentColor
            }
            .cornerRadius(10)
    }
}
