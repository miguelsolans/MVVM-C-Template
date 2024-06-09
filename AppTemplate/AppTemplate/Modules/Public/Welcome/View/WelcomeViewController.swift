//
//  WelcomeViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 31/05/2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: WelcomeViewModel! {
        didSet {
            viewModel.viewDelegate = self;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.titleLabel.text = NSLocalizedString("welcome_title_placeholder", tableName:"Welcome", comment: "");
        self.subtitleLabel.text = NSLocalizedString("welcome_subtitle_placeholder", tableName:"Welcome", comment: "");
        self.loginButton.setTitle(NSLocalizedString("welcome_login_button", tableName:"Welcome", comment: ""), for: .normal);
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.viewModel.didClickNext();
    }
}

extension WelcomeViewController: WelcomeViewModelDelegate {
    
}
