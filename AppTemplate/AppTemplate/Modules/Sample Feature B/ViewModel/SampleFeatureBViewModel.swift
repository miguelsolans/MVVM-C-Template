//
//  SampleFeatureBViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import Foundation

protocol SampleFeatureBViewModelCoordinatorDelegate: AnyObject {
}

protocol SampleFeatureBViewModelDelegate: AnyObject {
    
}

class SampleFeatureBViewModel {
    
    /// Set delegate with coordinator class
    weak var coordinatorDelegate: SampleFeatureBViewModelCoordinatorDelegate?
    
    /// Set delegate with view class
    weak var viewDelegate: SampleFeatureBViewModelDelegate?
    
    let title: String;
    
    init(title: String) {
        self.title = title;
    }
    
}

// MARK: - Network

extension SampleFeatureBViewModel { }
