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


class LoginViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        kakaoLoginButton.addTarget(self, action: #selector(tappedLogin), for: .touchUpInside)
    }
    
    
    @objc
    func tappedLogin() {
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
                        self.present(vc, animated: true)
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
                        self.present(vc, animated: true)
                    }

                }
            }
        }
    }
    
    override func setupView() {
        
        view.addSubview(topBaseView)
        topBaseView.addSubview(titleLabel)
        
        view.addSubview(kakaoLoginButton)
        view.addSubview(appleLoginButton)
        view.addSubview(naverLoginButton)
        
        
        
    }
    override func setupLayout() {
        topBaseView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.height.equalTo(200)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(topBaseView.snp.centerY)
            $0.leading.equalTo(topBaseView.snp.leading)
            $0.trailing.equalTo(topBaseView.snp.trailing)
            
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
        label.text = "로그인을 하세요"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let topBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
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
