//
//  HomeViewModel.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/03.
//

import Foundation
import RxSwift
import RxCocoa
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import RxKakaoSDKUser
import RxKakaoSDKCommon
import RxKakaoSDKAuth



protocol HomeViewModelBindable {
    associatedtype Input
    associatedtype Output
}

class HomeViewModel {
    private let disposeBag = DisposeBag()
    var infos: Observable<[Info]> = InfoNetworkImpl.shared.fetchInfos()
    


//    func getUserProfileInkakao() {
//
//        UserApi.shared.rx.me()
//            .map({ (user) -> User in
//                var scopes = [String]()
//
//                if (user.kakaoAccount?.profileNeedsAgreement == true) { scopes.append("profile") }
//                if (user.kakaoAccount?.emailNeedsAgreement == true) { scopes.append("account_email") }
//                if (scopes.count > 0) {
//                    print("사용자에게 추가 동의를 받아야 합니다.")
//                    throw SdkError(scopes:scopes)
//                } else {
//                    print("사용자의 추가 동의가 필요하지 않습니다.")
//                    return user
//                }
//            })
//            .retry(when: Auth.shared.rx.incrementalAuthorizationRequired())
//            .subscribe(onSuccess: { (user) in
//                print("me(): success.")
//
//                _ = user
//            }, onFailure: { error in
//                print(error)
//            })
//            .disposed(by: disposeBag)
//    }

    
}
