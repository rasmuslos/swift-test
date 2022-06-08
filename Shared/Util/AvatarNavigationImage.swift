//
//  AvatarNavigationImage.swift
//  iOS
//
//  Created by Rasmus Krämer on 08.06.22.
//

import SwiftUI

struct AvatarNavigationImage: View {
    @EnvironmentObject var loginState: LoginState
    
    var body: some View {
        AsyncImage(url: URL(string: loginState.avatarUrl)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60, alignment: .trailing)
                    .cornerRadius(20)
            } else {
                Image(systemName: "person.crop.circle")
                    .foregroundColor(.accentColor)
                    .scaledToFit()
                    .frame(width: 60, height: 60, alignment: .trailing)
            }
        }
        .padding(.bottom, -800)
    }
}
