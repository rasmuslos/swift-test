//
//  UnauthenticatedView.swift
//  test
//
//  Created by Rasmus Krämer on 06.06.22.
//

import SwiftUI

struct UnauthenticatedView: View {
    @State var presentingModal = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "person.fill.questionmark")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(Color.accentColor.opacity(0.8))
            
            Text("No user account configured")
                .font(.largeTitle)
                .fontWeight(.heavy)
            /*
                .padding(.top, 20)
                .padding(.bottom, 10)
             */
                .padding(.vertical)
            
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
