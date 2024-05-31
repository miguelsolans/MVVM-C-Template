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
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { user, error in
            if let error = error {
                self.viewDelegate?.loginDidEndWithError(error);
            } else {
                self.viewDelegate?.loginDidEndWithSuccess();
                self.coordinatorDelegate?.loginDidEndWithSuccess();
            }
        }
    }
}
