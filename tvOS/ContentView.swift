//
//  ContentView.swift
//  tvOS
//
//  Created by Rasmus Krämer on 12.03.22.
//

import SwiftUI

struct ContentView: View {
    enum Tab { case home, featured }
    @State var selection: Tab = Tab.home
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                Home()
                    .tabItem {
                        Text("Home")
                    }
                    .tag(Tab.home)
                
                
                Text("oof")
                    .tabItem {
                        Text("idk")
                    }
                    .tag(Tab.featured)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
