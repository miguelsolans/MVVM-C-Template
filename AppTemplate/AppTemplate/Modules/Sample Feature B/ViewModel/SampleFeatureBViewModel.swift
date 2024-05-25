//
//  SampleFeatureBViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import Foundation

protocol SampleFeatureBViewModelCoordinatorDelegate: AnyObject { }

protocol SampleFeatureBViewModelDelegate: AnyObject {
    func dummyUpdateWithSuccess(viewModel: SampleFeatureBViewModel);
    func dummyUpdateWithError(viewModel: SampleFeatureBViewModel);
}

class SampleFeatureBViewModel {
    
    /// Set delegate with coordinator class
    weak var coordinatorDelegate: SampleFeatureBViewModelCoordinatorDelegate?
    
    /// Set delegate with view class
    weak var viewDelegate: SampleFeatureBViewModelDelegate?
    
    let title: String;
    
    let client: SampleBClient
    
    var dummyOutput: SampleBModel?
    var dummyError: Error?
    
    init(title: String, client: SampleBClient) {
        self.title = title;
        self.client = client;
    }
    
}

// MARK: - Network

extension SampleFeatureBViewModel { 
    public func fetchData() {
        self.client
            .fetchSomeData { result in
                switch result {
                case .success(let data):
                    self.dummyOutput = data;
                    self.viewDelegate?.dummyUpdateWithSuccess(viewModel: self)
                case .failure(let error):
                    self.dummyError = error;
                    self.viewDelegate?.dummyUpdateWithError(viewModel: self);
                }
            }
    }
}
