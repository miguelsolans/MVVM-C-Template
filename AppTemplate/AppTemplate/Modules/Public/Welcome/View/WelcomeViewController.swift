//
//  WelcomeViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 31/05/2024.
//

import CoreKit
import UIKit

class WelcomeViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: WelcomeViewModel! {
        didSet {
            viewModel.viewDelegate = self;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.titleLabel.text = localizedString(forKey: "welcome_title_placeholder") // NSLocalizedString("welcome_title_placeholder", tableName:"Welcome", comment: "");
        self.subtitleLabel.text = localizedString(forKey: "welcome_subtitle_placeholder");
        self.registerButton.setTitle(localizedString(forKey:"welcome_register_button"), for: .normal)
        self.loginButton.setTitle(localizedString(forKey: "welcome_login_button"), for: .normal);
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        self.viewModel.didClickRegister();
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.viewModel.didClickLogin();
    }
}

extension WelcomeViewController: WelcomeViewModelDelegate {
    
}
