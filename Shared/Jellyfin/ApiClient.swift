//
//  ApiClient.swift
//  test
//
//  Created by Rasmus Krämer on 06.06.22.
//

import Foundation

public enum ApiError: Error {
    case invalidError(String)
    case failedError(Error)
}

public class JellyfinApiClient {
    public static let shared = {
        JellyfinApiClient()
    }()
    
    private(set) var server = ""
    private(set) var username = ""
    private var token = ""
    
    private init() {
        server = UserDefaults.standard.string(forKey: "jellyfin.server") ?? ""
        username = UserDefaults.standard.string(forKey: "jellyfin.username") ?? ""
        token = UserDefaults.standard.string(forKey: "jellyfin.token") ?? ""
    }
    
    public var loggedIn: Bool {
        get {
            return server != "" && username != "" && token != ""
        }
    }
    public func login(server: String, username: String, password: String) async throws {
        if !server.starts(with: "http") {
            throw ApiError.invalidError("Invalid url")
        }
        
        self.server = server
        
        do {
            let url = URL(string: "\(server)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            
            self.token = loginResponse.AccessToken
            self.username = loginResponse.User.Name
            
            UserDefaults.standard.set(self.server, forKey: "jellyfin.server")
            UserDefaults.standard.set(self.username, forKey: "jellyfin.username")
            UserDefaults.standard.set(self.token, forKey: "jellyfin.token")
        } catch {
            throw ApiError.failedError(error)
        }
    }
}
