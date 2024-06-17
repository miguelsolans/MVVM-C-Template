//
//  OnboardingSelfieViewModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 09/06/2024.
//

import Foundation
import UIKit

enum SelfieError: Error {
    case invalidImage(String)
    case noPersonDetected
    case moreThanOnePersonDetected
}

protocol OnboardingSelfieViewModelCoordinatorDelegate: AnyObject {
    func navigateToPersonalInfo();
}

protocol OnboardingSelfieViewModelDelegate: AnyObject {
    func imageValidationDidEndWithSuccess();
    func imageValidationDidEndWithError(_ error: SelfieError);
}

class OnboardingSelfieViewModel: NSObject {
    
    /// Coordinator delegate class
    weak var coordinatorDelegate: OnboardingSelfieViewModelCoordinatorDelegate?
    
    /// View delegate class
    weak var viewDelegate: OnboardingSelfieViewModelDelegate?
    
    public var selfieImage: UIImage? {
        didSet {
            self.validateImage();
        }
    }
    
    init(coordinatorDelegate: OnboardingSelfieViewModelCoordinatorDelegate? = nil, viewDelegate: OnboardingSelfieViewModelDelegate? = nil) {
        self.coordinatorDelegate = coordinatorDelegate
        self.viewDelegate = viewDelegate
    }
    
}

// MARK: - Actions

extension OnboardingSelfieViewModel {
    func didTapConfirm() {
        self.coordinatorDelegate?.navigateToPersonalInfo();
    }
}

// MARK: - Input data validation

extension OnboardingSelfieViewModel {
    @discardableResult
    func validateImage() -> Bool {
        
        var isValid = false;
        
        guard let image = selfieImage else {
            self.viewDelegate?.imageValidationDidEndWithError(.invalidImage("No image provided"))
            return isValid;
        }
        
        guard let ciImage = image.ciImage else {
            self.viewDelegate?.imageValidationDidEndWithError(.invalidImage("Error parsing image"))
            return isValid
        }
        
        let options = [
            CIDetectorAccuracy: CIDetectorAccuracyHigh
        ];
        
        guard let detector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options) else {
            self.viewDelegate?.imageValidationDidEndWithError(.invalidImage("Failed to detect person"))
            return isValid
        };
        
        
        let features = detector.features(in: ciImage, options: options)
        
        
        switch features.count {
        case 0:
            self.viewDelegate?.imageValidationDidEndWithError(.noPersonDetected)
            isValid = false;
        case 1:
            self.viewDelegate?.imageValidationDidEndWithSuccess()
            isValid = true
        default:
            self.viewDelegate?.imageValidationDidEndWithError(.moreThanOnePersonDetected)
            isValid = false
        }
        
        return isValid;
    }
}
