//
//  CameraManager.swift
//  AppTemplate
//
//  Created by Miguel Solans on 11/06/2024.
//

import UIKit
import AVFoundation

protocol CameraManagerDelegate: AnyObject {
    func cameraDidBeginSessionWithPreviewLater(_ previewLayer: AVCaptureVideoPreviewLayer);
    func cameraDidStopSessionFromPreviewLayer(_ previewLayer: AVCaptureVideoPreviewLayer);
    func cameraDidCaptureImage(_ image: UIImage);
}

class CameraManager: NSObject {
    
    fileprivate var viewController: UIViewController!
    
    // MARK: - Camera
    fileprivate var captureSession: AVCaptureSession!
    fileprivate var frontCamera: AVCaptureDevice!
    fileprivate var frontInput: AVCaptureInput!
    fileprivate var previewLayer : AVCaptureVideoPreviewLayer!
    fileprivate var videoOutput : AVCaptureVideoDataOutput!
    
    // MARK: Photo snap
    public var takePhoto: Bool = false;
    public weak var delegate: CameraManagerDelegate?
    
    fileprivate var onPhotoCaptured: ((UIImage) -> Void)?
    fileprivate var onPreviewLayer: ((AVCaptureVideoPreviewLayer) -> Void)?
    
    /// Setup and start camera capture
    /// - Parameters:
    ///   - viewController: UIViewController who requested camera to start
    ///   - onPreviewLayer: Code block executed upon camera output initialization
    ///   - onPhotoCaptured: Code block upon photo capture
    public func setup(from viewController: UIViewController, onPreviewLayer: @escaping ((AVCaptureVideoPreviewLayer) -> Void), onPhotoCaptured: @escaping ((UIImage) -> Void )) {
        self.viewController = viewController;
        self.onPhotoCaptured = onPhotoCaptured;
        self.onPreviewLayer = onPreviewLayer;
    }
    
    public func setup(from viewController: UIViewController) {
        self.viewController = viewController
    }
    
    /// Setup camera session and start capturing data
    fileprivate func setupAndCaptureSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession = AVCaptureSession();
            self.captureSession.beginConfiguration();
            
            if(self.captureSession.canSetSessionPreset(.photo)) {
                self.captureSession.sessionPreset = .photo;
            }
            
            self.setupSessionInput();
            
            DispatchQueue.main.async {
                self.setupPreviewLayer();
            }
            
            self.setupOutput();
            
            self.captureSession.commitConfiguration();
            self.captureSession.startRunning();
        }
    }
    
    /// Setup camera input session
    fileprivate func setupSessionInput() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            frontCamera = device;
        }
        
        guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
            return
        }
        
        frontInput = fInput;
        
        captureSession.addInput(frontInput);
    }
    
    /// Setup camera output
    fileprivate func setupOutput() {
        self.videoOutput = AVCaptureVideoDataOutput();
        let videoQueue = DispatchQueue(label: "videoQueue", qos: .userInteractive)
        self.videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        if(self.captureSession.canAddOutput(videoOutput)) {
            self.captureSession.addOutput(videoOutput)
        }
    }
    
    /// Setup preview layer
    ///
    /// Preview layer should be implemented by the calling ViewController / UIView
    fileprivate func setupPreviewLayer() {
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        
        self.onPreviewLayer?(previewLayer);
        self.delegate?.cameraDidBeginSessionWithPreviewLater(previewLayer);
    }
}

extension CameraManager {
    /// Start image capture
    public func startCapture() {
        
        if(UIDevice.current.isSimulator) {
            
            
        } else {
            PermissionManager.shared.requestAccess(to: .camera, from: self.viewController) { accessGranted in
                self.setupAndCaptureSession()
            }
        }
        
    }
    
    /// Stop image capture
    public func stopSession() {
        self.captureSession.stopRunning();
        
        self.delegate?.cameraDidStopSessionFromPreviewLayer(previewLayer);
        
        self.takePhoto = false;
    }
    
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        if(!self.takePhoto) {
            return
        }
        
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let ciImage = CIImage(cvImageBuffer: cvBuffer)
        
        let uiImage = UIImage(ciImage: ciImage);
        
        
        DispatchQueue.main.async {
            self.stopSession();
            self.delegate?.cameraDidCaptureImage(uiImage);
            
            self.takePhoto = false;
            
        }
    }
}
