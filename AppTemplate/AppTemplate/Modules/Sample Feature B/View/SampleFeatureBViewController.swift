//
//  SampleFeatureBViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit

class SampleFeatureBViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var viewModel: SampleFeatureBViewModel! {
        didSet {
            viewModel.viewDelegate = self;
        }
    }
    
    override func viewDidLoad() {
        self.title = viewModel.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.fetchData();
    }
}

extension SampleFeatureBViewController: SampleFeatureBViewModelDelegate {
    func dummyUpdateWithError(viewModel: SampleFeatureBViewModel) {
        self.titleLabel.text = "Error!";
        self.messageLabel.text = viewModel.dummyError?.localizedDescription;
    }
    
    func dummyUpdateWithSuccess(viewModel: SampleFeatureBViewModel) {
        self.titleLabel.text = viewModel.dummyOutput?.title;
        self.messageLabel.text = viewModel.dummyOutput?.message;
    }
}
