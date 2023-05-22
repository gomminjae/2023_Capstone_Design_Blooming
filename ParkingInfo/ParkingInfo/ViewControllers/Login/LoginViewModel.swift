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
import AuthenticationServices


enum LoginResult {
    case success(token: String)
    case failure(error: Error)
}

class LoginViewModel: NSObject {
    
    private let disposeBag = DisposeBag()
    
    let kakaoLoginResult: PublishSubject<LoginResult> = PublishSubject()
    let appleLoginResult: PublishSubject<LoginResult> = PublishSubject()
    
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaotalk()
        } else{
            loginWithKakaoAccount()
        }
    }
    
    func appleLogin() {
         let appleIDProvider = ASAuthorizationAppleIDProvider()
         let request = appleIDProvider.createRequest()
         request.requestedScopes = [.fullName, .email]
         
         let authorizationController =
         ASAuthorizationController(authorizationRequests: [request])
         authorizationController.delegate = self
         authorizationController.presentationContextProvider = self
         authorizationController.performRequests()
     }
    
    func handleLoginSuccess() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbar") as? UITabBarController {
            sceneDelegate.window?.rootViewController = tabBarController
        }
    }
    
    private func loginWithKakaotalk() {
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
            if let error = error {
                let result = LoginResult.failure(error: error)
                self.kakaoLoginResult.onNext(result)
                return
            } else {
                if let token = oauthToken?.accessToken {
                    let result = LoginResult.success(token: token)
                    self.kakaoLoginResult.onNext(result)
                }
            }
            print("kakao talk login sucessful")
        }
    }
    
    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                let result = LoginResult.failure(error: error)
                self.kakaoLoginResult.onNext(result)
                return
            } else {
                if let token = oauthToken?.accessToken {
                    let result = LoginResult.success(token: token)
                    self.kakaoLoginResult.onNext(result)
                }
            }
           
            print("kakao talk login sucessful")
        }
    }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            let token = appleIDCredential.identityToken?.base64EncodedString() ?? ""
            let result = LoginResult.success(token: token)
            appleLoginResult.onNext(result)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {

        let result = LoginResult.failure(error: error)
        appleLoginResult.onNext(result)
    }
}

extension LoginViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // Apple 로그인 컨트롤러의 표시 위치를 지정합니다.
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            fatalError("No active UIWindowScene available.")
        }
        return scene.windows.first ?? UIWindow()
    }
}




