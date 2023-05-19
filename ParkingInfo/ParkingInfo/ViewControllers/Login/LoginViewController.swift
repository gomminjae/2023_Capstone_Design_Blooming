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
        kakaoLoginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.login {
                    self?.setupInitialVC()
                }
            })
            .disposed(by: disposeBag)
        
        
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
