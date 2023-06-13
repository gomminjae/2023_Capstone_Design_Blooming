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
    }
    
    private func setupInitialVC() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "tabbar")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    override func setupView() {
        
        //view.addSubview(topBaseView)
        view.addSubview(titleLabel)
        //topBaseView.addSubview(subTitleLabel)
        view.addSubview(imageView)
        view.addSubview(kakaoLoginButton)
        view.addSubview(naverLoginButton)
        view.addSubview(appleLoginButton)
    }
    override func setupLayout() {
//        topBaseView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.leading.equalTo(view)
//            $0.trailing.equalTo(view)
//            $0.height.equalTo(view.frame.height / 2)
//        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(view).inset(120)
        }

//        subTitleLabel.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
//            $0.centerX.equalTo(titleLabel)
//        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.width.equalTo(400)
            $0.height.equalTo(400)
            $0.centerX.equalTo(view)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(40)

            $0.centerX.equalTo(view)
        }
        naverLoginButton.snp.makeConstraints {
            $0.top.equalTo(kakaoLoginButton.snp.bottom).offset(10)
            $0.centerX.equalTo(kakaoLoginButton)
            $0.height.equalTo(44)
            $0.width.equalTo(300)
        }

        appleLoginButton.snp.makeConstraints {
            $0.top.equalTo(naverLoginButton.snp.bottom).offset(10)
            $0.centerX.equalTo(naverLoginButton)
            $0.height.equalTo(44)
            $0.width.equalTo(300)
        }
    }
    override func bindRx() {
        kakaoLoginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.kakaoLogin()
            })
            .disposed(by: disposeBag)
        
        appleLoginButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.appleLogin()
            })
            .disposed(by: disposeBag)
        
        viewModel.kakaoLoginResult
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(_):
                    print("kakao Login Success")
                    self?.viewModel.handleLoginSuccess()
                case .failure(_):
                    print("kakao Login fail")
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.appleLoginResult
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(_):
                    print("Apple Login Success")
                    self?.viewModel.handleLoginSuccess()
                case .failure(_):
                    print("Apple Login fail")
                }
            })
            .disposed(by: disposeBag)
    }
    @objc private func handleAppleLoginTap() {
            // ASAuthorizationAppleIDButton의 탭 이벤트 처리를 위한 액션 메서드
        }
    
    //MARK: UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Blooming"
        label.textColor = .blueTitle
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "parking")
        return view
    }()
    
    
    let kakaoLoginButton: UIButton = {
        let button = UIButton()
        //button.setTitle(nil, for: .normal)
        button.setImage(UIImage(named: "kakao_login_medium_wide"), for: .normal)
        //button.imageView?.contentMode = .scaleToFill
        return button
    }()
    
    var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(handleAppleLoginTap), for: .touchUpInside)
        button.backgroundColor = .red
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return button
    }()

    let naverLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.01, green: 0.78, blue: 0.35, alpha: 1.00)
        button.setTitle("네이버 로그인", for: .normal)
        
        button.imageView?.contentMode = .scaleToFill
        return button
    }()
    
}
