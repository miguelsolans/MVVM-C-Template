//
//  WelcomeViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 01/06/2024.
//

import Foundation
import CoreKit

protocol WelcomeViewModelCoordinatorDelegate: AnyObject {
    func navigateToLoginPage();
    func navigateToRegisterPage();
}

protocol WelcomeViewModelDelegate: AnyObject {
    
}

class WelcomeViewModel: NSObject {
    
    weak var coordinatorDelegate: WelcomeViewModelCoordinatorDelegate?;
    
    weak var viewDelegate: WelcomeViewModelDelegate?;
    
    public func didClickRegister() {
        self.coordinatorDelegate?.navigateToRegisterPage();
    }
    
    public func didClickLogin() {
        self.coordinatorDelegate?.navigateToLoginPage();
    }
}
