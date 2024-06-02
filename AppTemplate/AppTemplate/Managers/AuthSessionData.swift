//
//  AuthSessionData.swift
//  AppTemplate
//
//  Created by Miguel Solans on 02/06/2024.
//

import Foundation
import GoogleSignIn

enum AuthenticationProvider {
    /// Authentication via Google Sin-in
    case google
    /// Authentication via Facebook
    case facebook
    /// Authentication via Username-Password
    case username
}

struct AuthSessionData {
    let googleUser: GIDGoogleUser?
    let provider: AuthenticationProvider
}
