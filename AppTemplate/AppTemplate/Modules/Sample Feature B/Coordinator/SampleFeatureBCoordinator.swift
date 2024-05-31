//
//  SampleFeatureBCoordinator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit
import CoreKit

protocol SampleFeatureBCoordinatorDelegate: AnyObject {
    func logoutEndWithSuccess(coordinator: SampleFeatureBCoordinator);
}

class SampleFeatureBCoordinator: BaseCoordinator {
    
    weak var delegate: SampleFeatureBCoordinatorDelegate?
    
    let navigationController: UINavigationController
    
    let storyboard: UIStoryboard = {
        return UIStoryboard(name: "SampleFeatureB", bundle: nil);
    }()
    
    let apiClient: SampleBClient = {
        let configuration = ApiClientConfiguration();
        
        let baseURL = PlistHelper.getStringValue(forKey: PlistConstants.baseURL)!
        
        let client = SampleBClient(baseURL: baseURL, configuration: configuration)
        
        return client;
    }()
    
    let title: String;
    
    init(navigationController: UINavigationController, title: String) {
        self.navigationController = navigationController
        self.title = title;
        super.init()
    }
    
    override func start() {
        self.navigationController.pushViewController(sampleFeatureViewController, animated: true)
    }
    
    override func finish() {
        
    }
    
    // MARK: - ViewModel / ViewController's
    
    lazy var sampleFeatureBViewModel: SampleFeatureBViewModel = {
        let viewModel = SampleFeatureBViewModel(title: title, client: apiClient);
        
        viewModel.coordinatorDelegate = self;
        
        return viewModel
    }()
    
    lazy var sampleFeatureViewController = {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SampleFeatureBViewController") as! SampleFeatureBViewController;
        
        viewController.viewModel = self.sampleFeatureBViewModel;
        
        viewController.tabBarItem.title = self.title;
        
        return viewController;
    }();
    
    lazy var anotherSampleFeatureViewController = {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SampleFeatureBViewController") as! SampleFeatureBViewController;
        
        viewController.hidesBottomBarWhenPushed = true
        viewController.viewModel = self.sampleFeatureBViewModel;
        
        return viewController;
    }();
}

extension SampleFeatureBCoordinator: SampleFeatureBViewModelCoordinatorDelegate {
    func didTapNext() {
        self.goToAnotherPage()
    }
    
    func didSignOut() {
        
    }
    
    func loginDidEndWithSuccess(viewModel: SampleFeatureAViewModel) {
        
    }
}

// MARK: - Navigation
extension SampleFeatureBCoordinator {
    public func goToAnotherPage() {
        
        self.navigationController.pushViewController(anotherSampleFeatureViewController, animated: true)
    }
}
