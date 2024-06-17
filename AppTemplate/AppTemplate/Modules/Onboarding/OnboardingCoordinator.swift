//
//  OnboardingCoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 01/06/2024.
//

import CoreKit
import UIKit

class OnboardingCoordinator: BaseCoordinator {
    
    let navigationController: UINavigationController
    
    // MARK: - Storyboard's
    
    let selfieStoryboard = UIStoryboard(name: StoryboardConstants.selfie, bundle: nil);
    
    let personalInfoStoryboard = UIStoryboard(name: StoryboardConstants.personalInfo, bundle: nil);
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    
    override func start() {
        
        self.goToSelfiePage()
        
    }
    
    override func finish() {
        
    }
    
    // MARK: - ViewModel's / ViewController's
    
    lazy var selfieViewController: OnboardingSelfieViewController = {
        let viewController = selfieStoryboard.instantiateViewController(identifier: "SelfieViewController") as! OnboardingSelfieViewController;
        
        let viewModel = OnboardingSelfieViewModel();
        viewModel.coordinatorDelegate = self;
        
        viewController.viewModel = viewModel;
        
        return viewController;
    }();
    
    lazy var personalInfoViewController: OnboardingPersonalInformationViewController = {
        let viewController = personalInfoStoryboard.instantiateViewController(identifier: "OnboardingPersonalInformationViewController") as! OnboardingPersonalInformationViewController;
        
        return viewController
    }();
}

extension OnboardingCoordinator: OnboardingSelfieViewModelCoordinatorDelegate {
    func navigateToPersonalInfo() {
        self.goToPersonalInfoPage();
    }
}

extension OnboardingCoordinator {
    
    func goToSelfiePage() {
        self.navigationController.pushViewController(selfieViewController, animated: true);
    }
    
    func goToPersonalInfoPage() {
        self.navigationController.pushViewController(personalInfoViewController, animated: true);
    }
    
}
