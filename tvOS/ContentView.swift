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
        TabView(selection: $selection) {
            Home()
                .tabItem {
                    Text("Home")
                }
                .tag(Tab.home)
            
            
            Text("oof")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(Tab.featured)
        }
        
        .onAppear() {
            // This does not work - fuck UIKit / SwiftUI and what not
            // UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
            UIScrollView.appearance().automaticallyAdjustsScrollIndicatorInsets = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
