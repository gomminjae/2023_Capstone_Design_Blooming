//
//  Info.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/13.
//

import Foundation


struct Info: Codable, Equatable {
    
    var parkinlotsTitle: String
    var parkingState: String
    var isStarred: Bool
    
    init(parkinlotsTitle: String, parkingState: String, isStarred: Bool = false) {
        self.parkinlotsTitle = parkinlotsTitle
        self.parkingState = parkingState
        self.isStarred = isStarred
    }
}
