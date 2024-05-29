//
//  SampleBClient.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import CoreKit

class SampleBClient: BaseApiClient {
    
    func fetchSomeData(completion: @escaping (Result<SampleBModel, ApiError>) -> Void) {
        self.request(endpoint: "/user", method: .get, completion: completion)
    }
}
