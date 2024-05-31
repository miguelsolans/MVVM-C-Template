//
//  ProfileViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 31/05/2024.
//

import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        GIDSignIn.sharedInstance.signOut();
        
        let result = GIDSignIn.sharedInstance.hasPreviousSignIn();
        
        // TODO: Change coordinator
    }

}
