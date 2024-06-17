//
//  OnboardingPersonalInfoViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 14/06/2024.
//

import Foundation
import CoreKit

protocol OnboardingPersonalInfoViewModelCoordinatorDelegate: AnyObject {
    
}

protocol OnboardingPersonalInfoViewModelDelegate: AnyObject {
    
}

class OnboardingPersonalInfoViewModel {
    /// Coordinator delegate class
    weak var coordinatorDelegate: OnboardingPersonalInfoViewModelCoordinatorDelegate?;
    
    /// View delegate class
    weak var viewDelegate: OnboardingPersonalInfoViewModelDelegate?;
    
    init(coordinatorDelegate: OnboardingPersonalInfoViewModelCoordinatorDelegate? = nil, viewDelegate: OnboardingPersonalInfoViewModelDelegate? = nil) {
        self.coordinatorDelegate = coordinatorDelegate
        self.viewDelegate = viewDelegate
    }
}

extension OnboardingPersonalInfoViewModel {
    
    func setInfo(_ info: PersonalInfoModel) {
        
        if(self.isInfoValid()) {
            
        } else {
            
        }
    }
}

extension OnboardingPersonalInfoViewModel {
    
    func isInfoValid() -> Bool {
        return true;
    }
    
    func validateName() {
        
    }
}
