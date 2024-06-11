//
//  SelfieViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 09/06/2024.
//

import Foundation
import UIKit



class SelfieViewModel: NSObject {
    
    var selfieImage: UIImage? {
        didSet {
            self.validateImage();
        }
    }
    
    
    
}

// MARK: - Input data validation

extension SelfieViewModel {
    func validateImage() {
        
    }
}
