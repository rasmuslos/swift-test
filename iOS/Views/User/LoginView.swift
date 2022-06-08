//
//  LoginView.swift
//  iOS
//
//  Created by Rasmus Krämer on 06.06.22.
//

import SwiftUI

fileprivate enum Field: Hashable {
    case server
    case username
    case password
}

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var loginState: LoginState
    
    @State public var server: String = ""
    @State public var username: String = ""
    @State public var password: String = ""
    @State private var showingAlert = false
    
    @FocusState private var focusedField: Field?
    
    func processCredentials() {
        guard !server.isEmpty else {
            focusedField = .server
            return
        }
        guard !username.isEmpty else {
            focusedField = .username
            return
        }
        
        Task {
            let success = await loginState.login(server: server, username: username, password: password)
            
            if success {
                dismiss()
            } else {
                showingAlert = true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Instance", text: $server)
                    .keyboardType(.URL)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .server)
                
                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .username)
                
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .password)
            }
            .onSubmit {
                processCredentials()
            }
            
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if loginState.isLoading {
                    ProgressView()
                } else {
                    Button("Continue") {
                        processCredentials()
                    }
                }
            }
            .alert("Login failed", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
