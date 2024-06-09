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
    func loginRestoreDidEndWithError(error: Error);
    func onboardRequirementDidEndWithSuccess(onboarding requiresOnboarding: Bool);
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
    
    /// Client
    let client: SignInClient
    
    init(coordinatorDelegate: SignInViewModelCoordinatorDelegate? = nil, viewDelegate: SignInViewModelDelegate? = nil, client: SignInClient) {
        self.coordinatorDelegate = coordinatorDelegate
        self.viewDelegate = viewDelegate
        self.client = client
    }

}

extension SignInViewModel {
    /// Login with Google sign-in
    func signInWithGoogle() {
        guard let viewController = UIApplication.shared.windows.first?.rootViewController else { return }
        
        SessionManager.shared.signIn(with: .google, viewController: viewController) { result in
            switch result {
            case .success( _):
                self.viewDelegate?.loginDidEndWithSuccess()
                self.coordinatorDelegate?.loginDidEndWithSuccess()
            case .failure(let error):
                self.viewDelegate?.loginDidEndWithError(error)
            }
        }
    }
    
    /// Attempt to restore previous sign-in
    func restoreLogin() {
        SessionManager.shared.restorePreviousSignIn(with: .google) { result in
            switch result {
            case .success( _):
                self.coordinatorDelegate?.loginDidEndWithSuccess();
                break;
            case .failure(let error):
                self.viewDelegate?.loginDidEndWithError(error);
                self.coordinatorDelegate?.loginRestoreDidEndWithError(error: error);
                break;
            }
        }
    }
    
    /// Check onboarding requirement
    func checkOnboardRequirement() {
        self.client.getOnboardingRequirement { result in
            switch(result) {
            case .success(let data):
                self.coordinatorDelegate?.onboardRequirementDidEndWithSuccess(onboarding: data.requiresOnboarding)
                break;
            case .failure(let error):
                break;
            }
        }
    }
    
}
