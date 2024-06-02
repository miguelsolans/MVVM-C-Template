//
//  SignInViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 31/05/2024.
//

import CoreKit
import GoogleSignIn

protocol SignInViewModelCoordinatorDelegate: AnyObject {
    func loginDidEndWithSuccess();
}

protocol SignInViewModelDelegate: AnyObject {
    func loginDidEndWithSuccess();
    func loginDidEndWithError(_ error: Error);
}

class SignInViewModel: NSObject {
    
    /// Coordinator delegate class
    weak var coordinatorDelegate: SignInViewModelCoordinatorDelegate?;
    
    /// View delegate class
    weak var viewDelegate: SignInViewModelDelegate?;
    
    /// Login with Google sign-in
    func signInWithGoogle() {
        guard let viewController = UIApplication.shared.windows.first?.rootViewController else { return }
        
        SessionManager.shared.signIn(with: .google, viewController: viewController) { result in
            switch result {
            case .success(let authSessionData):
                self.viewDelegate?.loginDidEndWithSuccess()
            case .failure(let error):
                self.viewDelegate?.loginDidEndWithError(error)
            }
        }
    }
}
