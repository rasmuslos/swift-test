//
//  ApiClient.swift
//  test
//
//  Created by Rasmus Krämer on 06.06.22.
//

import Foundation

public class LoginState: ObservableObject {
    @Published public var loggedIn = JellyfinApiClient.shared.loggedIn
    @Published public var avatarUrl = ""
    
    @Published private(set) var isLoading = false
    
    @MainActor
    func login(server: String, username: String, password: String) async -> Bool {
        isLoading = true
        loggedIn = false
        
        do {
            let avatarImageTag = try await JellyfinApiClient.shared.login(server: server, username: username, password: password)
            
            loggedIn = true
            isLoading = false
            avatarUrl = "\(JellyfinApiClient.shared.server)/Users/\(JellyfinApiClient.shared.userId)/Images/Primary?tag=\(avatarImageTag)&quality=90&maxHeight=180"
            return true
        } catch {
            isLoading = false
            return false
        }
    }
}

public class JellyfinApiClient {
    public static let shared = {
        JellyfinApiClient()
    }()
    
    private(set) var uuid = "" {
        didSet {
            UserDefaults.standard.set(self.uuid, forKey: "jellyfin.uuid")
        }
    }
    
    private(set) var server = "" {
        didSet {
            UserDefaults.standard.set(self.server, forKey: "jellyfin.server")
        }
    }
    private(set) var userId = "" {
        didSet {
            UserDefaults.standard.set(self.username, forKey: "jellyfin.userId")
        }
    }
    private(set) var username = "" {
        didSet {
            UserDefaults.standard.set(self.username, forKey: "jellyfin.username")
        }
    }
    private(set) var token = "" {
        didSet {
            UserDefaults.standard.set(self.token, forKey: "jellyfin.token")
        }
    }
    
    private init() {
        server = UserDefaults.standard.string(forKey: "jellyfin.server") ?? ""
        userId = UserDefaults.standard.string(forKey: "jellyfin.userId") ?? ""
        username = UserDefaults.standard.string(forKey: "jellyfin.username") ?? ""
        token = UserDefaults.standard.string(forKey: "jellyfin.token") ?? ""
        
        guard let uuid = UserDefaults.standard.string(forKey: "jellyfin.uuid") else {
            self.uuid = NSUUID().uuidString
            return
        }
        self.uuid = uuid
    }
    
    public var loggedIn: Bool {
        get {
            return server != "" && username != "" && token != ""
        }
    }
    public func login(server: String, username: String, password: String) async throws -> String {
        if !server.starts(with: "http") {
            throw ApiError.invalidError("Invalid url")
        }
        
        do {
            self.server = server
            let loginResponse = try await makeRequest(endpoint: "Users/AuthenticateByName", decodable: LoginResponse.self, method: "POST", body: ["Username": username, "Pw": password])
            
            self.token = loginResponse.AccessToken
            self.userId = loginResponse.User.Id
            self.username = loginResponse.User.Name
            
            return loginResponse.User.PrimaryImageTag
        } catch {
            self.server = ""
            
            debugPrint(error)
            throw ApiError.failedError(error)
        }
    }
    public func logout() async {
        try? await makeRequest(endpoint: "Sessions/Logout")
        
        self.server = ""
        self.token = ""
        self.username = ""
    }
    
    public func makeRequest<T: Codable>(endpoint: String, decodable: T.Type, method: String = "POST", body: [String: Any]? = nil) async throws -> T {
        do {
            let url = URL(string: "\(server)/\(endpoint)")!
            var request = URLRequest(url: url)
            request.httpMethod = method
            
            if body != nil {
                let bodyData = try JSONSerialization.data(withJSONObject: body!, options: [])
                
                request.httpBody = bodyData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            request.setValue("MediaBrowser Client=\"iOS\", Device=\"iOS\", Version=\"0.0.0\", DeviceId=\"\(uuid)\", Token=\(token)", forHTTPHeaderField: "X-Emby-Authorization")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(decodable, from: data)
        } catch {
            debugPrint(error)
            throw ApiError.failedError(error)
        }
    }
    public func makeRequest(endpoint: String, method: String = "POST", body: [String: Any]? = nil) async throws {
        let _ = try await makeRequest(endpoint: endpoint, decodable: EmptyResponse.self, method: method, body: body)
    }
}
