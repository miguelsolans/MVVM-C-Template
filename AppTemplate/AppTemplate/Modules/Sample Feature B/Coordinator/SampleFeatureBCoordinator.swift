//
//  SampleFeatureBCoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit

class SampleFeatureBCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    let storyboard: UIStoryboard = {
        return UIStoryboard(name: "SampleFeatureB", bundle: nil);
    }()
    
    let title: String;
    
    init(navigationController: UINavigationController, title: String) {
        self.navigationController = navigationController
        self.title = title;
    }
    
    override func start() {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SampleFeatureBViewController") as! SampleFeatureBViewController;
        
        viewController.viewModel = self.sampleFeatureBViewModel;
        
        self.navigationController.viewControllers = [viewController];
    }
    
    override func finish() {
        
    }
    
    // MARK: - ViewModel / ViewController's
    
    lazy var sampleFeatureBViewModel: SampleFeatureBViewModel = {
        let viewModel = SampleFeatureBViewModel(title: title);
        
        viewModel.coordinatorDelegate = self;
        
        return viewModel
    }()
}

extension SampleFeatureBCoordinator: SampleFeatureBViewModelCoordinatorDelegate {
    func loginDidEndWithSuccess(viewModel: SampleFeatureAViewModel) {
        
    }
}
