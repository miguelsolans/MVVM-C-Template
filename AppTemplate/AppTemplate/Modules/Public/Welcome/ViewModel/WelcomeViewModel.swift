//
//  WelcomeViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 01/06/2024.
//

import Foundation
import CoreKit

protocol WelcomeViewModelCoordinatorDelegate: AnyObject {
    func welcomeDidEndWithSuccess();
}

protocol WelcomeViewModelDelegate: AnyObject {
    
}

class WelcomeViewModel: NSObject {
    
    weak var coordinatorDelegate: WelcomeViewModelCoordinatorDelegate?;
    
    weak var viewDelegate: WelcomeViewModelDelegate?;
    
    
    public func didClickNext() {
        self.coordinatorDelegate?.welcomeDidEndWithSuccess();
    }
}
