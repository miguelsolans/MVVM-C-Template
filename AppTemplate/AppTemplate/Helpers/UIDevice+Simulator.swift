//
//  UIDevice+Simulator.swift
//  AppTemplate
//
//  Created by Miguel Solans on 17/06/2024.
//

import UIKit

extension UIDevice {
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    };
}
