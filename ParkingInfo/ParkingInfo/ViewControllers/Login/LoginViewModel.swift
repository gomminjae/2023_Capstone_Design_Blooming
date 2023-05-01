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



protocol ViewModelType {
    var disposeBag: DisposeBag { get set }
    
    associatedtype Input
    associatedtype Output
}

class LoginViewModel {
    
    private let disposeBag = DisposeBag()
    
    
    func Login() {
        if (UserApi.isKakaoTalkLoginAvailable()) {

            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")

                    if oauthToken?.accessToken != nil {
                        let vc = UINavigationController(rootViewController: HomeViewController())
                        vc.modalPresentationStyle = .fullScreen
                        //self.present(vc, animated: true)
                    }
                }
            }
        } else {
            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")

                    //let token = oauthToken
                    if oauthToken?.accessToken != nil {
                        let vc = UINavigationController(rootViewController: HomeViewController())
                        vc.modalPresentationStyle = .fullScreen
                        //self.present(vc, animated: true)
                    }

                }
            }
        }
        
    }
    
    
    
    
    
    
}
