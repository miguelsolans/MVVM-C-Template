//
//  SampleBModel.swift
//  AppTemplate
//
//  Created by Miguel Solans on 21/05/2024.
//

import Foundation

struct SampleBModel: Codable {
    let title: String;
    let message: String;
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case message = "Message"
    }
}
