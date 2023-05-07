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


protocol APICompose {
    var baseUrl: URL { get }
    var subUrl: String { get }
}

class APIService: APICompose {
    
    static let shared = APIService()
    
    var baseUrl: URL {
        guard let url = URL(string: "http://15.164.140.81:8080/")
         else { fatalError() }
        return url
    }
    
    var subUrl: String {
        return "dummy"
    }
    
    func fetchPosts() -> Observable<[Info]> {
        return Observable.create { observer -> Disposable in
            AF.request("http://15.164.140.81:8080/dummy")
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
    
    func postToken(token: Dictionary<String, Any>) {
        let url = "http://15.164.140.81:8080/getToken?value"
        AF.request(url,method: .post, parameters: token, encoding: URLEncoding.queryString)
            .responseData { response in
                switch response.result {
                case .success:
                    print("POST 성공")
                case .failure(let error):
                    print(error)
                }
        }
        
    }
    
    
    
}
