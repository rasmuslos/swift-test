//
//  UnauthenticatedView.swift
//  test
//
//  Created by Rasmus Krämer on 06.06.22.
//

import SwiftUI

struct UnauthenticatedView: View {
    @State var presentingModal = true
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "person.fill.questionmark")
                .font(.system(size: 100))
                .foregroundColor(Color.accentColor.opacity(0.8))
            
            Text("You are not logged in")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Text("To login provide your Jellyfin server url as well as a username and password")
                .font(.title3)
            
            Spacer()
            
            Button("Login") {
                presentingModal.toggle()
            }
            .buttonStyle(LargeButtonStyle())
            .sheet(isPresented: $presentingModal) {
                LoginView()
            }
        }
        .padding()
    }
}

struct UnauthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        UnauthenticatedView()
    }
}
