//
//  SampleFeatureAViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import CoreKit

protocol SampleFeatureAViewModelCoordinatorDelegate: AnyObject {
    func loginDidEndWithSuccess(viewModel: SampleFeatureAViewModel);
}

protocol SampleFeatureAViewModelDelegate: AnyObject {
    
}

class SampleFeatureAViewModel {
    
    /// Set delegate with coordinator class
    weak var coordinatorDelegate: SampleFeatureAViewModelCoordinatorDelegate?
    
    /// Set delegate with view class
    weak var viewDelegate: SampleFeatureAViewModelDelegate?
    
}

// MARK: - Network

extension SampleFeatureAViewModel {
    public func login() {
        self.coordinatorDelegate?.loginDidEndWithSuccess(viewModel: self);
    }
}
