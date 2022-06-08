//
//  ApiResponses.swift
//  test
//
//  Created by Rasmus Krämer on 06.06.22.
//

import Foundation

public enum ApiError: Error {
    case invalidError(String)
    case failedError(Error)
}

struct EmptyResponse: Codable {}

/// Reponse returned when logging in
struct LoginResponse: Codable {
    let User: LoginUser
    let AccessToken: String
    let ServerId: String
}
struct LoginUser: Codable {
    let Id: String
    let Name: String
    let ServerId: String
    let PrimaryImageTag: String
}
