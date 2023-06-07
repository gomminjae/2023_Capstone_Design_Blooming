//
//  APIService.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/03.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire


struct Token: Decodable {
    let refreshToken: String
    let accessToken: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken
        case accessToken
        case tokenType
    }
}

class InfoNetworkImpl {
    
    
    static let shared = InfoNetworkImpl()
    
    func fetchInfos() -> Observable<[Info]> {
        return Observable.create { observer -> Disposable in
            AF.request("http://118.67.142.142:8080/dummy")
                .validate()
                .responseDecodable(of: [Info].self) { response in
                    switch response.result {
                    case .success(let posts):
                        observer.onNext(posts)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    //["Content-Type":"application/x-www-form-urlencoded", "Accept":"application/x-www-form-urlencoded"]
    func postToken(params: [String:String]) {
        let url = "http://15.164.140.81:8080/login"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseString { response in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    func postToServer(params: [String:String]) {
        // 요청할 URL
        guard let url = URL(string: "http://15.164.140.81:8080/login") else { return }
        
        // 요청에 필요한 파라미터
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
        
        // HTTP 요청 설정
        var request = URLRequest(url: url) 
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        // URLSession을 통해 요청 보내기
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // 응답 처리
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response: \(json)")
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
