//
//  SampleFeatureACoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit
import CoreKit

protocol SampleFeatureACoordinatorDelegate: AnyObject {
    func loginDidEndWithSuccess(coordinator: SampleFeatureACoordinator);
}

class SampleFeatureACoordinator: BaseCoordinator {
    
    weak var delegate: SampleFeatureACoordinatorDelegate?
    
    let navigationController: UINavigationController
    
    let storyboard = UIStoryboard(name: "SampleFeatureA", bundle: nil);
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SampleFeatureAViewController") as! SampleFeatureAViewController;
        
        viewController.viewModel = self.sampleFeatureAViewModel;
        
        self.navigationController.viewControllers = [viewController];
    }
    
    override func finish() {
        self.delegate?.loginDidEndWithSuccess(coordinator: self);
    }
    
    // MARK: - ViewModel's / ViewController's
    
    lazy var sampleFeatureAViewModel: SampleFeatureAViewModel = {
        let viewModel = SampleFeatureAViewModel();
        
        viewModel.coordinatorDelegate = self;
        
        return viewModel;
    }()
    
}

extension SampleFeatureACoordinator: SampleFeatureAViewModelCoordinatorDelegate {
    func loginDidEndWithSuccess(viewModel: SampleFeatureAViewModel) {
        self.delegate?.loginDidEndWithSuccess(coordinator: self);
    }
}
