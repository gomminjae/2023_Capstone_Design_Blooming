//
//  LoginViewController.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/02.
//

import UIKit
import RxSwift
import SnapKit

class LoginViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        
        
    }
    override func bindRx() {
        
        
    }
    
    
    //MARK: UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
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
        button.setTitle("Kakao Login", for: .normal)
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
