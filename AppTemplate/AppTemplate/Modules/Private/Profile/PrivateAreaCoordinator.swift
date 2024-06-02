//
//  PrivateAreaCoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 01/06/2024.
//

import CoreKit
import UIKit

protocol PrivateAreaCoordinatorDelegate: AnyObject {
    func coordinatorDidFinish(_ coordinator: PrivateAreaCoordinator);
}

class PrivateAreaCoordinator: BaseCoordinator {
    
    weak var delegate: PrivateAreaCoordinatorDelegate?

    let navigationController: UINavigationController
    
    let profileStoryboard = UIStoryboard(name: StoryboardConstants.profile, bundle: nil)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        self.goToProfile()
    }
    
    override func finish() {
        
    }
    
    // MARK: - ViewModel's / ViewController's
    
    lazy var profileViewController: ProfileViewController = {
        let viewController = profileStoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
        let viewModel = ProfileViewModel();
        viewModel.coordinatorDelegate = self;
        
        viewController.viewModel = viewModel;
        
        return viewController
    }();
    
}

// MARK: - Navigation

extension PrivateAreaCoordinator {
    func goToProfile() {
        self.navigationController.viewControllers = [profileViewController];
    }
}

extension PrivateAreaCoordinator: ProfileViewModelCoordinatorDelegate {
    func logoutDidFinishWithSuccess() {
        self.delegate?.coordinatorDidFinish(self);
    }
}
