//
//  SampleFeatureAViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit


class SampleFeatureAViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: SampleFeatureAViewModel! {
        didSet {
            viewModel.viewDelegate = self;
        }
    }
    
    // MARK: - Outlets
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system);
        button.translatesAutoresizingMaskIntoConstraints = false;
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style();
        self.layout();
        self.setupActions();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    private func style() {
        loginButton.setTitle("Login", for: .normal);
    }
    
    private func layout() {
        self.view.addSubview(self.loginButton);
        
        NSLayoutConstraint.activate([
            self.loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]);
    }
    
    private func setupActions() {
        self.loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
    }
    
}

// MARK: - Actions

extension SampleFeatureAViewController {
    @objc func loginButtonTapped(_ sender: UIButton) {
        self.viewModel.login();
    }
}


// MARK: - ViewModel delegates

extension SampleFeatureAViewController: SampleFeatureAViewModelDelegate {
    
}
