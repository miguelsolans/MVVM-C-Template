//
//  AppCoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit
import CoreKit


class AppCoordinator: BaseCoordinator  {
    
    // MARK: - Properties
    let window: UIWindow?
    
    lazy var clientConfiguration: ApiClientConfiguration = {
        let configuration = ApiClientConfiguration();
        
        return configuration;
    }();
    
    lazy var rootViewController: UINavigationController = {
        let rootViewController = UINavigationController();
        
        rootViewController.navigationBar.prefersLargeTitles = false;
        
        return rootViewController;
    }()
    
    lazy var tabBarController: TabBar = {
        let viewController = TabBar();
        
        return viewController;
    }()
    
    // MARK: - Methods
    
    init(window: UIWindow?) {
        self.window = window
        
    }
    
    override func start() {
        guard let window else { return }
        
        window.rootViewController = self.rootViewController;
        window.makeKeyAndVisible();
        
        self.checkAuth();
    }
    
    override func finish() {
        
    }
    
    // MARK: - ViewModel's / ViewController's
    
    lazy var signInViewModel: SignInViewModel = {
        
        let client = SignInClient(baseURL: "", configuration: clientConfiguration)
        
        let viewModel = SignInViewModel(client: client)
        
        viewModel.coordinatorDelegate = self;
        
        return viewModel;
    }()
    
    fileprivate func checkAuth() {
        // Override point for customization after application launch.
        self.signInViewModel.restoreLogin()
    }
    
}

// MARK: - Public Area Coordinator
extension AppCoordinator: PublicAreaCoordinatorDelegate {
    
    /// Use this extension to setup public coordinators, which do not require user authentication
    ///
    /// In this example, we are setting-up a blank UIViewController with a single action
    func setupPublicCoordinators() {
        let coordinator = self.setupWelcomeCoordinator();
        
        self.window?.rootViewController = coordinator.navigationController;
    }
    
    func setupWelcomeCoordinator() -> PublicAreaCoordinator {
        let navigationController = UINavigationController();
        
        let coordinator = PublicAreaCoordinator(navigationController: navigationController);

        coordinator.signInViewModel = self.signInViewModel;
        coordinator.delegate = self;
        
        self.addChildCoordinator(coordinator);
        
        coordinator.start();
        
        return coordinator;
    }
    
    func coordinatorDidFinish(_ coordinator: PublicAreaCoordinator) {
        self.removeChildCoordinator(coordinator);
    }
    
}

// MARK: - Private Area Coordinator
extension AppCoordinator: PrivateAreaCoordinatorDelegate {
    
    func setupPrivateCoordinators() {
        let navigationController = UINavigationController();
        
        let coordinator = PrivateAreaCoordinator(navigationController: navigationController);
        
        coordinator.delegate = self;
        
        coordinator.start();
        
        self.window?.rootViewController = coordinator.navigationController;
        
    }
    
    func coordinatorDidFinish(_ coordinator: PrivateAreaCoordinator) {
        self.removeChildCoordinator(coordinator);
        
        self.setupPublicCoordinators();
    }
}

extension AppCoordinator: SignInViewModelCoordinatorDelegate {
    func loginDidEndWithSuccess() {
        self.setupPrivateCoordinators();
    }
    
    func loginRestoreDidEndWithError(error: Error) {
        self.setupPublicCoordinators();
    }
    
    func onboardRequirementDidEndWithSuccess(onboarding requiresOnboarding: Bool) {
    }
}
