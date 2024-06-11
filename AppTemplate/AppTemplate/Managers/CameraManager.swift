//
//  CameraManager.swift
//  AppTemplate
//
//  Created by Miguel Solans on 11/06/2024.
//

import UIKit
import AVFoundation

class CameraManager: NSObject {
    
    var viewController: UIViewController!
    
    // MARK: - Camera
    var captureSession: AVCaptureSession!
    var frontCamera: AVCaptureDevice!
    var frontInput: AVCaptureInput!
    var previewLayer : AVCaptureVideoPreviewLayer!
    var videoOutput : AVCaptureVideoDataOutput!
    
    // MARK: Photo snap
    var takePhoto: Bool = false;
    var onPhotoCaptured: ((UIImage) -> Void)?
    var onPreviewLayer: ((AVCaptureVideoPreviewLayer) -> Void)?
    
    func setup(from viewController: UIViewController, onPreviewLayer: @escaping ((AVCaptureVideoPreviewLayer) -> Void), onPhotoCaptured: @escaping ((UIImage) -> Void )) {
        self.viewController = viewController;
        self.onPhotoCaptured = onPhotoCaptured;
        self.onPreviewLayer = onPreviewLayer;
        
        self.startCapture()
    }

    
    func startCapture() {
        PermissionManager.shared.requestAccess(to: .camera, from: self.viewController) { accessGranted in
            self.setupAndCaptureSession()
        }
    }
    
    func setupAndCaptureSession() {
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
    
    func setupSessionInput() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            frontCamera = device;
        }
        
        guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
            return
        }
        
        frontInput = fInput;
        
        captureSession.addInput(frontInput);
    }
    
    func setupOutput() {
        self.videoOutput = AVCaptureVideoDataOutput();
        let videoQueue = DispatchQueue(label: "videoQueue", qos: .userInteractive)
        self.videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        if(self.captureSession.canAddOutput(videoOutput)) {
            self.captureSession.addOutput(videoOutput)
        }
    }
    
    func setupPreviewLayer() {
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        
        self.onPreviewLayer?(previewLayer);
        // self.previewView.layer.insertSublayer(previewLayer, at: 0);
        
        // self.previewView.superview?.layer.insertSublayer(previewLayer, above: self.previewView.layer) // .layer.insertSublayer(previewLayer, above: selfieView.layer);
        
        // self.previewLayer.frame = selfieView.layer.frame
    }
    
    func stopSession() {
        self.captureSession.stopRunning();
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
        
        self.onPhotoCaptured?(uiImage);
        
        DispatchQueue.main.async {
            self.takePhoto = false;
            self.stopSession();
        }
    }
}
