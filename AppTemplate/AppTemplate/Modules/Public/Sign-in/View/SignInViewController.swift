//
//  SignInViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 31/05/2024.
//

import UIKit
import GoogleSignIn

class SignInViewController: UIViewController {
    
    public var viewModel: SignInViewModel! {
        didSet {
            viewModel.viewDelegate = self;
        }
    }
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.setupGestures();
        self.style();
    }
    
    func style() {
        
    }
    
    func setupGestures() {
        let googleSignInGesture = UITapGestureRecognizer(target: self, action: #selector(googleSignInButtonTapped(_:)))
        
        self.googleSignInButton.addGestureRecognizer(googleSignInGesture);
    }
}

extension SignInViewController {
    @objc func googleSignInButtonTapped(_ gesture: UITapGestureRecognizer) {
        self.viewModel.signInWithGoogle();
    }
}



extension SignInViewController: SignInViewModelDelegate {
    func loginDidEndWithSuccess() {
        print("SignInViewController | Signed-in with success")
    }
    
    func loginDidEndWithError(_ error: any Error) {
        print("SignInViewController | There was a problem during sign-in")
    }
    
    
}
