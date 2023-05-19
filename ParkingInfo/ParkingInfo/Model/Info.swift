//
//  Info.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/13.
//

import Foundation


struct Info: Codable, Equatable {
    
    var parkinglotsTitle: String
    var parkingState: String
    var isStarred: Bool?
    var timeStamp: String
    
    
    private enum CodingKeys: String, CodingKey {
        case parkinglotsTitle = "parkingLotName"
        case parkingState = "status"
        case isStarred = "favorite"
        case timeStamp
    }
    
    
}
