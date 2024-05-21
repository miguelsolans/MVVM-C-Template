//
//  SampleFeatureBViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit

class SampleFeatureBViewController: UIViewController {
    // MARK: - Properties
    
    var viewModel: SampleFeatureBViewModel! {
        didSet {
            viewModel.viewDelegate = self;
        }
    }
    
    override func viewDidLoad() {
        self.title = viewModel.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}

extension SampleFeatureBViewController: SampleFeatureBViewModelDelegate {
    
}
