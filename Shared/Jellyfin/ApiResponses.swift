//
//  ApiResponses.swift
//  test
//
//  Created by Rasmus Krämer on 06.06.22.
//

import Foundation

/// Reponse returned when logging in
struct LoginResponse: Codable {
    let User: LoginUser
    let AccessToken: String
    let ServerId: String
}
struct LoginUser: Codable {
    let Name: String
    let ServerId: String
    let ServerName: String
}
