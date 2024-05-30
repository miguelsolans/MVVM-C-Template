//
//  PlistManager.swift
//  AppTemplate
//
//  Created by Miguel Solans on 30/05/2024.
//

import Foundation

public class PlistManager {
    static let shared = PlistManager();
    
    private init() { }
    
    public func getValue(forKey key: String) -> Any? {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            return nil;
        }
        
        return infoDictionary[key]
    }
    
    public func getStringValue(forKey key: String) -> String? {
        return getValue(forKey: key) as? String
    }
    
    public func getIntValue(forKey key: String) -> Int? {
        return getValue(forKey: key) as? Int
    }
    
    public func getBoolValue(forKey key: String) -> Bool? {
        return getValue(forKey: key) as? Bool
    }
}
