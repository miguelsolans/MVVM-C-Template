//
//  ProfileViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 31/05/2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModel! {
        didSet {
            viewModel.viewDelegate = self;
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.titleLabel.text = NSLocalizedString("profile_welcome_title", tableName:"Profile", comment: "");
        self.logoutButton.setTitle(NSLocalizedString("profile_logout_button", tableName:"Profile", comment: ""), for: .normal);
        self.viewModel.getUserInfo()
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        self.viewModel.logout();
        
    }

}


extension ProfileViewController: ProfileViewModelDelegate {
    func logoutDidFinishWithError() {
        
    }
    
    func updateWithUserName(_ userName: String) {
        self.usernameLabel.text = userName;
    }
    
}
