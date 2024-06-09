//
//  SignInClient.swift
//  AppTemplate
//
//  Created by Miguel Solans on 02/06/2024.
//

import CoreKit

class SignInClient: BaseApiClient {
    
    func getOnboardingRequirement(completion: @escaping (Result<SignInModel, ApiError>) -> Void) {
        self.request(endpoint: "/onboard/requirement", method: .get, completion: completion);
    }
}
