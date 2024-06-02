//
//  SessionManager.swift
//  AppTemplate
//
//  Created by Miguel Solans on 02/06/2024.
//

import UIKit
import GoogleSignIn

class SessionManager: NSObject {
    
    static let shared = SessionManager()

    public var sessionData: AuthSessionData?
    
    /// Sign-in to a federated authentication service
    /// - Parameters:
    ///   - provider: Authentication service provider
    ///   - viewController: Root view-controller
    ///   - completion: Code-block executed upon completion
    public func signIn(with provider: AuthenticationProvider, viewController: UIViewController, completion: @escaping (Result<AuthSessionData, Error>) -> Void) {
        switch provider {
        case .google:
            self.signInWithGoogle(from: viewController, completion: completion)
            break;
        case .facebook:
            break;
        case .username:
            break;
        }
    }
    
    fileprivate func signInWithGoogle(from viewController: UIViewController, completion: @escaping (Result<AuthSessionData, Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { user, error in
            
            if let error = error {
                completion(.failure(error))
                return
            } else {
                let sessionInfo = AuthSessionData(googleUser: user?.user, provider: .google)
                
                self.sessionData = sessionInfo;
                
                completion(.success(sessionInfo))
            }
            
        }
    }
    
    fileprivate func signInWithFacebook() {
        
    }
}
