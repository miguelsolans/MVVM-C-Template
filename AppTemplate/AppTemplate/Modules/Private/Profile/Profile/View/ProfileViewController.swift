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
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
