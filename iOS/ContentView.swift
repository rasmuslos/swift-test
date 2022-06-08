//
//  ContentView.swift
//  iOS
//
//  Created by Rasmus Krämer on 12.03.22.
//

import SwiftUI
import Introspect

struct ContentView: View {
    @StateObject var loginState = LoginState()
    
    var body: some View {
        NavigationView {
            if loginState.loggedIn {
                Text("Hello \(JellyfinApiClient.shared.server):\(JellyfinApiClient.shared.username) / \(JellyfinApiClient.shared.uuid) / \(JellyfinApiClient.shared.token)")
                // .navigationBarItems(leading: Text("why").font(.title), trailing: AvatarNavigationImage())
                    .toolbar {
                        ToolbarItem(id: "avatar", placement: .navigationBarTrailing, showsByDefault: true) {
                            AvatarNavigationImage()
                        }
                    }
                    .navigationTitle("FUCK")
            } else {
                UnauthenticatedView()
            }
        }
        .environmentObject(loginState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
