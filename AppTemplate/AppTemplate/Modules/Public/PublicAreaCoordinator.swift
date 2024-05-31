//
//  PublicAreaCoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 31/05/2024.
//

import UIKit
import CoreKit

protocol PublicAreaCoordinatorDelegate: AnyObject {
    func coordinatorDidFinish(_ coordinator: PublicAreaCoordinator);
}

class PublicAreaCoordinator: BaseCoordinator {
    
    weak var delegate: PublicAreaCoordinatorDelegate?;
    
    let navigationController: UINavigationController
    
    let welcomeStoryboard = UIStoryboard(name: StoryboardConstants.welcome, bundle: nil)
    
    let signInStoryboard = UIStoryboard(name: StoryboardConstants.signIn, bundle: nil)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() {
        self.goToWelcomePage()
    }
    
    override func finish() {
        self.delegate?.coordinatorDidFinish(self);
    }
    
    // MARK: - ViewModel's / ViewController's
    
    lazy var welcomeViewController: WelcomeViewController = {
        let viewController = welcomeStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        
        let viewModel = WelcomeViewModel();
        viewModel.coordinatorDelegate = self;
        
        viewController.viewModel = viewModel;
        
        return viewController;
    }()
    
    lazy var signInViewController: SignInViewController = {
        let viewController = signInStoryboard.instantiateViewController(identifier: "SignInViewController") as! SignInViewController
        
        let viewModel = SignInViewModel();
        viewModel.coordinatorDelegate = self;
        
        viewController.viewModel = viewModel;
        
        return viewController;
    }()
}

// MARK: - Navigation

extension PublicAreaCoordinator {
    /// Go to initial page
    func goToWelcomePage() {
        self.navigationController.viewControllers = [welcomeViewController];
    }
    
    /// Go to login page
    func goToLoginPage() {
        self.navigationController.pushViewController(signInViewController, animated: true)
    }
    
    /// Go to recover password page
    func goToRecoverPasswordPage() {
        
    }
    
    /// Go to register account page
    func goToRegisterPage() {
        
    }
    
}

extension PublicAreaCoordinator: WelcomeViewModelCoordinatorDelegate {
    func welcomeDidEndWithSuccess() {
        self.goToLoginPage();
    }
}

extension PublicAreaCoordinator: SignInViewModelCoordinatorDelegate {
    func loginDidEndWithSuccess() {
        self.finish();
    }
}
