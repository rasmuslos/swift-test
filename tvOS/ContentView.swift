//
//  ContentView.swift
//  tvOS
//
//  Created by Rasmus Krämer on 12.03.22.
//

import SwiftUI
import Introspect

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
                .introspectScrollView { scrollView in
                    scrollView.automaticallyAdjustsScrollIndicatorInsets = false
                    scrollView.contentInsetAdjustmentBehavior = .never
                    scrollView.bounces = false
                    scrollView.isScrollEnabled = false
                }
                .introspectTabBarController { tabView in
                    tabView.automaticallyAdjustsScrollViewInsets = false
                    tabView.tabBarObservedScrollView?.contentInsetAdjustmentBehavior = .never
                    tabView.tabBarObservedScrollView?.isScrollEnabled = false
                }
                .introspectViewController { view in
                    view.automaticallyAdjustsScrollViewInsets = false
                    view.tabBarObservedScrollView?.contentInsetAdjustmentBehavior = .never
                }
            
            
            Text("oof")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(Tab.featured)
        }
        .introspectScrollView { scrollView in
            scrollView.automaticallyAdjustsScrollIndicatorInsets = false
            scrollView.contentInsetAdjustmentBehavior = .never
            scrollView.bounces = false
            scrollView.isScrollEnabled = false
        }
        .introspectTabBarController { tabView in
            tabView.automaticallyAdjustsScrollViewInsets = false
            tabView.tabBarObservedScrollView?.contentInsetAdjustmentBehavior = .never
            tabView.tabBarObservedScrollView?.isScrollEnabled = false
        }
        .introspectViewController { view in
            view.automaticallyAdjustsScrollViewInsets = false
            view.tabBarObservedScrollView?.contentInsetAdjustmentBehavior = .never
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
