//
//  SelfieViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 09/06/2024.
//

import UIKit
import AVFoundation

class OnboardingSelfieViewController: UIViewController {
    
    public var viewModel: OnboardingSelfieViewModel! {
        didSet {
            viewModel.viewDelegate = self;
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var selfieView: UIView!
    @IBOutlet weak var snapSelfieButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    
    fileprivate var ovalShapeLayer: CAShapeLayer?
    
    // MARK: - Camera
    fileprivate var cameraManager: CameraManager!;
    fileprivate var isPreview: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraManager = CameraManager();
        
        setupUI();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        cameraManager.setup(from: self);
        cameraManager.delegate = self;
        
        cameraManager.startCapture();
    }
    
    func setupUI() {
        self.snapSelfieButton.isHidden = false;
        self.confirmButton.isHidden = true;
        self.repeatButton.isHidden = true;
    }

    func setupOvalShape(in previewLayer: AVCaptureVideoPreviewLayer ) {
        
        guard self.ovalShapeLayer == nil else { return }
        if self.isPreview { return }
        
            
        let width: CGFloat = previewLayer.frame.size.width;
        let height: CGFloat = previewLayer.frame.size.height;
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.selfieView.bounds.size.width, height: self.selfieView.bounds.size.height), cornerRadius: 0)
        let rect = CGRect(x: width / 2 - 150, y: height / 2.5 - 100, width:  300, height: 400)
        let circlePath = UIBezierPath(ovalIn: rect)
        path.append(circlePath)
        path.usesEvenOddFillRule = true

        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 0.5
        
        self.ovalShapeLayer = fillLayer;
        
        view.layer.addSublayer(fillLayer)
    }
}

// MARK: - Actions

extension OnboardingSelfieViewController {
    
    @IBAction func snapSelfieButtonTapped(_ sender: Any) {
        self.cameraManager.takePhoto = true;
    }
    
    @IBAction func repeatButtonTapped(_ sender: Any) {
        self.cameraManager.takePhoto = false;
        
        self.cameraManager.startCapture();
        
        self.snapSelfieButton.isHidden = false;
        self.confirmButton.isHidden = true;
        self.repeatButton.isHidden = true;
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        self.viewModel.didTapConfirm();
    }
    
}

extension OnboardingSelfieViewController: OnboardingSelfieViewModelDelegate {
    func imageValidationDidEndWithError(_ error: SelfieError) {
        
        self.confirmButton.isHidden = true;
        self.repeatButton.isHidden = true;
        self.snapSelfieButton.isHidden = false;
        self.isPreview = false;
        
        let alert = UIAlertController(title: "", message: "Error capturing selfie", preferredStyle: .alert);
        let okAction = UIAlertAction(title: "Ok", style: .default);
        alert.addAction(okAction)
        
        self.present(alert, animated: true);
        
    }
    
    func imageValidationDidEndWithSuccess() {
        self.confirmButton.isHidden = false;
        self.repeatButton.isHidden = false;
        self.snapSelfieButton.isHidden = true;
        self.isPreview = true;
    }
}


extension OnboardingSelfieViewController: CameraManagerDelegate {
    func cameraDidBeginSessionWithPreviewLater(_ previewLayer: AVCaptureVideoPreviewLayer) {
        self.view.layer.insertSublayer(previewLayer, above: self.selfieView.layer)
        
        previewLayer.frame = self.selfieView.layer.frame
        
        previewLayer.videoGravity = .resizeAspectFill;
        
        self.setupOvalShape(in: previewLayer);
    }
    
    
    func cameraDidStopSessionFromPreviewLayer(_ previewLayer: AVCaptureVideoPreviewLayer) {
        self.ovalShapeLayer?.removeFromSuperlayer()
        self.ovalShapeLayer = nil;
    }
    
    func cameraDidCaptureImage(_ image: UIImage) {
        self.viewModel.selfieImage = image;
    }
    
}
