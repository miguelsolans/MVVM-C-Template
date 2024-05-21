//
//  AppCoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit

class AppCoordinator: BaseCoordinator {

    
    // MARK: - Properties
    let window: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        let rootViewController = UINavigationController();
        
        rootViewController.navigationBar.prefersLargeTitles = false;
        
        return rootViewController;
    }()
    
    lazy var tabBarController: UITabBarController = {
        let viewController = UITabBarController();
        
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
        
        self.setupPublicCoordinators();
    }
    
    override func finish() {
        
    }
    
}

// MARK: - Public Area Coordinator
extension AppCoordinator: SampleFeatureACoordinatorDelegate {
    
    /// Use this extension to setup public coordinators, which do not require user authentication
    ///
    /// In this example, we are setting-up a blank UIViewController with a single action
    func setupPublicCoordinators() {
        let coordinator = self.setupFeatureACoordinator();
        
        self.window?.rootViewController = coordinator.navigationController;
    }
    
    func setupFeatureACoordinator() -> SampleFeatureACoordinator {
        let navigationController = UINavigationController();
        
        let coordinator = SampleFeatureACoordinator(navigationController: navigationController);
        
        coordinator.delegate = self;
        
        self.addChildCoordinator(coordinator);
        
        coordinator.start();
        
        return coordinator;
    }
    
    func loginDidEndWithSuccess(coordinator: SampleFeatureACoordinator) {
        self.removeChildCoordinator(coordinator);
        
        self.setupPrivateCoordinators();
    }
}

// MARK: - Private Area Coordinator
extension AppCoordinator {
    
    /// Use this extension to setup private coordinators which require user authentication
    ///
    /// In this example, we are setting-up a UITabBar based page as a private area
    func setupPrivateCoordinators() {
        let coordinatorB = self.setupFeatureBCoordinator();
        let coordinatorC = self.setupFeatureCCoordinator();
        
        self.tabBarController.viewControllers = [
            coordinatorB.navigationController,
            coordinatorC.navigationController
        ];
        
        self.window?.rootViewController = self.tabBarController
    }
    
    func setupFeatureBCoordinator() -> SampleFeatureBCoordinator {
        let navigationController = UINavigationController();
        
        let coordinator = SampleFeatureBCoordinator(navigationController: navigationController, title: "Feature B");
        
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
