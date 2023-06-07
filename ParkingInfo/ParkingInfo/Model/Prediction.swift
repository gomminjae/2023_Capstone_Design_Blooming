//
//  Prediction.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/28.
//

import Foundation


struct Prediction: Codable {
    let predictions: [Int]
    
    enum CodingKeys: String, CodingKey {
        case predictions
    }
}
