//
//  StatusCodeResponse.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/03.
//

import Foundation


enum ResponseResult {
    case success
    case badRequest
    case serverError
    case failure
}

struct StatusCodeResponse {
    func result(_ response: HTTPURLResponse) -> ResponseResult {
        switch response.statusCode {
        case 200: return .success
        case 400..<500: return .badRequest
        case 500..<600: return .serverError
        default: return .failure
        }
    }
}
