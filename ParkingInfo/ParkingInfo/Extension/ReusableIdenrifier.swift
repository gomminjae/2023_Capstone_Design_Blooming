//
//  ReusableIdenrifier.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/13.
//

import Foundation

extension String {
    
    static var reusableIdentifier(): String {
        return String(describing: self)
    }
}
