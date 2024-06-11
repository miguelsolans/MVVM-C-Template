//
//  PermissionManager.swift
//  AppTemplate
//
//  Created by Miguel Solans on 11/06/2024.
//

import Foundation
import UIKit
import AVFoundation

enum Permission {
    case camera
    case addressBook
    case photoLibrary
    case microphone
}

class PermissionManager {
    
    static let shared = PermissionManager()
    
    func requestAccess(to permission: Permission, from viewController: UIViewController, completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        
        switch permission {
        case .camera:
            self.requestCameraUsage(from: viewController, completionHandler: completionHandler)
        case .addressBook:
            print("TBD")
        case .photoLibrary:
            print("TBD")
        case .microphone:
            print("TBD")
        }
        
    }
    
    fileprivate func requestCameraUsage(from viewController: UIViewController, completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video);
        
        switch authorizationStatus {
        case .authorized:
            completionHandler(true);
        case .denied:
            completionHandler(false);
        case .notDetermined, .restricted:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completionHandler(granted)
            }
        @unknown default:
            print("Unknown");
        }
    }
    
    fileprivate func showSettingsAlert(from viewController: UIViewController, message: String, completionHandler: @escaping (_ accessGranted: Bool) -> Void ) {
        
    }
}
