//
//  WelcomeViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 31/05/2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var viewModel: WelcomeViewModel! {
        didSet {
            viewModel.viewDelegate = self;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.viewModel.didClickNext();
    }
}

extension WelcomeViewController: WelcomeViewModelDelegate {
    
}
