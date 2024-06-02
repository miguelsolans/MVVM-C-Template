//
//  AppCoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit
import CoreKit
import GoogleSignIn


class AppCoordinator: BaseCoordinator  {
    
    // MARK: - Properties
    let window: UIWindow?
    
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
    
    fileprivate func checkAuth() {
        // Override point for customization after application launch.
        
        // Try to restore sign-in state of users already sign-in with Google
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if((error != nil) || (user == nil)) {
                // Show app signed-out state
                print("Google Auth | Signed-out state");
                self.setupPublicCoordinators();
            } else {
                // Show App signed-in state
                print("Google Auth | Signed-in state");
                self.setupPrivateCoordinators()
            }
        }
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

        coordinator.delegate = self;
        
        self.addChildCoordinator(coordinator);
        
        coordinator.start();
        
        return coordinator;
    }
    
    func coordinatorDidFinish(_ coordinator: PublicAreaCoordinator) {
        self.removeChildCoordinator(coordinator);
        
        self.setupPrivateCoordinators();
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
    
    /// Use this extension to setup private coordinators which require user authentication
    ///
    /// In this example, we are setting-up a UITabBar based page as a private area
    /*func setupPrivateCoordinators() {
        let coordinatorB = self.setupFeatureBCoordinator();
        let coordinatorC = self.setupFeatureCCoordinator();
        
        self.tabBarController.viewControllers = [
            coordinatorB.navigationController,
            coordinatorC.navigationController
        ];
        
        self.window?.rootViewController = self.tabBarController
    }*/
    
    func setupFeatureBCoordinator() -> SampleFeatureBCoordinator {
        let navigationController = UINavigationController();
        
        let coordinator = SampleFeatureBCoordinator(navigationController: navigationController, title: "Feature B");
        
        coordinator.delegate = self;
        
        coordinator.start();
        
        return coordinator;
    }
    
    func setupFeatureCCoordinator() -> SampleFeatureBCoordinator {
        let navigationController = UINavigationController();
        
        let coordinator = SampleFeatureBCoordinator(navigationController: navigationController, title: "Feature C");
        
        coordinator.start();
        
        return coordinator;
    }
}


extension AppCoordinator: SampleFeatureBCoordinatorDelegate {
    func logoutEndWithSuccess(coordinator: SampleFeatureBCoordinator) {
        self.setupPublicCoordinators()
    }
}
