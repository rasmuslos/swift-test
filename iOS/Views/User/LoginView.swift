//
//  LoginView.swift
//  iOS
//
//  Created by Rasmus Krämer on 06.06.22.
//

import SwiftUI

struct LoginView: View {
    @State private var server: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("server url", text: $server)
                        .disableAutocorrection(false)
                        .textInputAutocapitalization(.never)
                    TextField("username", text: $username)
                        .disableAutocorrection(false)
                        .textInputAutocapitalization(.never)
                    SecureField("password", text: $password)
                        .disableAutocorrection(false)
                        .textInputAutocapitalization(.never)
                }
                
                .navigationTitle("Login")
                .toolbar {
                    Button("Continue") {
                        
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
