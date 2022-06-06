//
//  ContentView.swift
//  iOS
//
//  Created by Rasmus Krämer on 12.03.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            if JellyfinApiClient.shared.loggedIn {
                Text("Hello")
            } else {
                UnauthenticatedView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
