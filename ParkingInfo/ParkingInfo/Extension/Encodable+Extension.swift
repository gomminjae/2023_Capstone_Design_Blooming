//
//  Encodable+extension.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/06.
//

import Foundation


extension Encodable {
    func encode() throws -> [String:Any] {
        let data = try JSONEncoder().encode(self)
        guard let dic = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { throw NSError() }
        
        return dic
    }
}

[
    Token: ""
    
]
