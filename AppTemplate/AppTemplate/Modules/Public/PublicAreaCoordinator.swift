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
    
    var signInViewModel: SignInViewModel?;
    
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
        
        viewController.viewModel = signInViewModel;
        
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
        
        let coordinator = OnboardingCoordinator(navigationController: navigationController);
        
        self.addChildCoordinator(coordinator);
        
        coordinator.start();
    }
    
}

// MARK: - Welcome Coordinator delegates

extension PublicAreaCoordinator: WelcomeViewModelCoordinatorDelegate {
    func navigateToLoginPage() {
        self.goToLoginPage();
    }
    
    func navigateToRegisterPage() {
        self.goToRegisterPage();
    }
}
