//
//  WeathModel.swift
//  WeatherUIKit
//
//  Created by Mikhail Ivanov on 06.10.2021.
//

import Foundation


struct WeathModel: Codable {
    
    var city: String?
    var fact: WeathFactModel
    
    enum CodingKeys: String, CodingKey {
        case fact
    }
    
}

struct WeathFactModel: Codable {
    
    var temp: Int
}
