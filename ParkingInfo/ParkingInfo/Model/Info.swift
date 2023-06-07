//
//  Info.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/13.
//

import Foundation


struct Info: Codable {
    
    var parkinglotsTitle: String
    var timeStamp: String
    var total: Int
    var empty: Int
    
    private enum CodingKeys: String, CodingKey {
        case parkinglotsTitle = "title"
        case total
        case empty
        case timeStamp
    }
    
    
}
