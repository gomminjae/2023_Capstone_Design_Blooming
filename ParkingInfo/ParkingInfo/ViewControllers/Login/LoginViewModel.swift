//
//  LoginViewModel.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/03.
//

import Foundation
import RxSwift
import RxCocoa
import KakaoSDKAuth
import KakaoSDKUser


class LoginViewModel {
    
    private let disposeBag = DisposeBag()
    
    let isLoggedIn: Observable<Bool>
    
    init() {
        isLoggedIn = Observable.create { observer in
            if AuthApi.hasToken() {
                observer.onNext(true)
            } else {
                observer.onNext(false)
            }
            
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    
    func login(completion: @escaping () -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaotalk()
        }else { loginWithKakaoAccount()}
    }
    
    func logout() {
        UserApi.shared.logout { error in
            if let error = error {
                print(error)
                return
            }
            
            print("logout Sucessful")
        }
    }
    
    
    private func loginWithKakaotalk() {
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
            if let error = error {
                print(error)
                return
            }
            guard (oauthToken?.accessToken) != nil else {
                print("token is missing")
                return
            }
            
            print("kakao talk login sucessful")
        }
    }
    
    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard (oauthToken?.accessToken) != nil else {
                print("token is missing")
                return
            }
            
            print("kakao talk login sucessful")
        }
    }
}




