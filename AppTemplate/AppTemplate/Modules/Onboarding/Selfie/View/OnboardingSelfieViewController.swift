//
//  SelfieViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 09/06/2024.
//

import UIKit
import AVFoundation

class OnboardingSelfieViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var selfieView: UIView!
    @IBOutlet weak var snapSelfieButton: UIButton!
    
    // MARK: - Camera
    var cameraManager: CameraManager!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraManager = CameraManager();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        cameraManager.setup(from: self) { previewLayer in
            self.view.layer.insertSublayer(previewLayer, above: self.selfieView.layer)
            previewLayer.frame = self.selfieView.layer.frame
        } onPhotoCaptured: { image in
            print("Image captured!");
        }
    }
    
    @IBAction func snapSelfieButtonTapped(_ sender: Any) {
        self.cameraManager.takePhoto = true;
    }
    
}


extension OnboardingSelfieViewController {
    // TODO: Set ViewModel properties
    
}
