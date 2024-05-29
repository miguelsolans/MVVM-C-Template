//
//  SampleFeatureBCoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit
import CoreKit

class SampleFeatureBCoordinator: BaseCoordinator {
    let navigationController: UINavigationController
    
    let storyboard: UIStoryboard = {
        return UIStoryboard(name: "SampleFeatureB", bundle: nil);
    }()
    
    let apiClient: SampleBClient = {
        let configuration = ApiClientConfiguration();
        
        let client = SampleBClient(baseURL: "http://localhost:3001", configuration: configuration)
        
        return client;
    }()
    
    let title: String;
    
    init(navigationController: UINavigationController, title: String) {
        self.navigationController = navigationController
        self.title = title;
        super.init()
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
        let viewModel = SampleFeatureBViewModel(title: title, client: apiClient);
        
        viewModel.coordinatorDelegate = self;
        
        return viewModel
    }()
}

extension SampleFeatureBCoordinator: SampleFeatureBViewModelCoordinatorDelegate {
    func loginDidEndWithSuccess(viewModel: SampleFeatureAViewModel) {
        
    }
}
