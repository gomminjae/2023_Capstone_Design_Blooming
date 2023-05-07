//
//  LoginViewController.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/02.
//

import UIKit
import RxSwift
import SnapKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices


class LoginViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        kakaoLoginButton.addTarget(self, action: #selector(loginByKakao()), for: .touchUpInside)
    }
    
    private func setupInitialVC() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "tabbar")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    
    @objc
    func loginByKakao() {
        if (UserApi.isKakaoTalkLoginAvailable()) {

            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")

                    if oauthToken?.accessToken != nil {
                        self.setupInitialVC()
                        do {
                            let dic = try oauthToken?.encode()
                            print("------->\(String(describing: dic))")
                            InfoNetworkImpl.shared.postToken(token: dic!)
                        } catch {
                            print(error)
                            print("post error")
                        }
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
                        self.setupInitialVC()
                    }

                }
            }
        }
    }
    
    @objc
    func loginByApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName,.email]
    }
    
    
    override func setupView() {
        
        view.addSubview(topBaseView)
        topBaseView.addSubview(titleLabel)
        topBaseView.addSubview(subTitleLabel)
        
        view.addSubview(kakaoLoginButton)
        view.addSubview(appleLoginButton)
        view.addSubview(naverLoginButton)
        
        
        
    }
    override func setupLayout() {
        topBaseView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.height.equalTo(view.frame.height / 2)
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(topBaseView)
            $0.top.equalTo(topBaseView).inset(40)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(titleLabel)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(topBaseView.snp.bottom).offset(40)
            $0.leading.equalTo(view).inset(40)
            $0.trailing.equalTo(view).inset(40)
            
        }
        
        
        
    }
    override func bindRx() {
        
        
        
    }
    
    //MARK: UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "당신의 주차를 편하게!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    let topBaseView: CurvedView = {
        let view = CurvedView()
        //view.backgroundColor = .blue
        return view
    }()
    
    let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakao_login_medium_wide"), for: .normal)
        return button
    }()
    
    let appleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apple Login", for: .normal)
        return button
    }()
    
    let naverLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Naver Login", for: .normal)
        return button
    }()
    
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    private func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
    private func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            
    }
    
}
