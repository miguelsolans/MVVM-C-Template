//
//  ProfileViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 01/06/2024.
//

import UIKit
import CoreKit
import GoogleSignIn

protocol ProfileViewModelCoordinatorDelegate: AnyObject {
    func logoutDidFinishWithSuccess();
}

protocol ProfileViewModelDelegate: AnyObject {
    func updateWithUserName(_ userName: String);
    
    func logoutDidFinishWithError();
}

class ProfileViewModel: NSObject {
    /// Set delegate with coordinator class
    var coordinatorDelegate: ProfileViewModelCoordinatorDelegate?
    
    /// Set delegate with view class
    var viewDelegate: ProfileViewModelDelegate?
    
    public var user: GIDGoogleUser?
    
    func getUserInfo() {
        self.user = GIDSignIn.sharedInstance.currentUser;
        
        guard let profile = self.user?.profile else { return }
        
        
        self.viewDelegate?.updateWithUserName(profile.name);
    }
    
    func logout() {
        GIDSignIn.sharedInstance.signOut();
        
        self.coordinatorDelegate?.logoutDidFinishWithSuccess();
    }
}
