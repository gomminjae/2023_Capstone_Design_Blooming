//
//  StatusCodeResponse.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/03.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case error(String)
    case defaultError
    
    var message: String? {
        switch self {
        case let .error(msg):
            return msg
        case .defaultError:
            return "잠시 후에 다시 시도해주세요."
        }
    }
}


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

protocol InfoNetwork {
    func getInfos() -> Observable<Result<[Info], NetworkError>>
}
