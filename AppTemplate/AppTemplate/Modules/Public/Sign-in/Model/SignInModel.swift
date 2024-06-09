//
//  SignInModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 02/06/2024.
//

import Foundation

struct SignInModel: Decodable {
    let requiresOnboarding: Bool
    
    enum CodingKeys: String, CodingKey {
        case requiresOnboarding = "RequiresOnboarding"
    }
}
