//
//  PlistHelper.swift
//  AppTemplate
//
//  Created by Miguel Solans on 30/05/2024.
//

import Foundation

class PlistHelper: NSObject {
    
    static func getValue(forKey key: String) -> Any? {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            return nil;
        }
        
        return infoDictionary[key]
    }
    
    static func getStringValue(forKey key: String) -> String? {
        return getValue(forKey: key) as? String
    }
    
    static func getIntValue(forKey key: String) -> Int? {
        return getValue(forKey: key) as? Int
    }
    
    static func getBoolValue(forKey key: String) -> Bool? {
        return getValue(forKey: key) as? Bool
    }
    
}
