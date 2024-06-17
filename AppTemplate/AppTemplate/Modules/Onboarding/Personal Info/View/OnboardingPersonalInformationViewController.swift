//
//  OnboardingPersonalInformationViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 10/06/2024.
//

import UIKit

class OnboardingPersonalInformationViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        self.firstNameTextField.placeholder = "First name";
        self.firstNameTextField.keyboardType = .namePhonePad;
        self.firstNameTextField.delegate = self;
        self.lastNameTextField.placeholder = "Last name";
        self.lastNameTextField.keyboardType = .namePhonePad;
        self.lastNameTextField.delegate = self;
        self.emailTextField.placeholder = "E-mail"
        self.emailTextField.keyboardType = .emailAddress;
        self.emailTextField.delegate = self;
    }
    
}

extension OnboardingPersonalInformationViewController {
    @IBAction func confirmButtonTapped(_ sender: Any) {
        
    }
}

extension OnboardingPersonalInformationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}

extension OnboardingSelfieViewController: OnboardingPersonalInfoViewModelDelegate {
    
}
