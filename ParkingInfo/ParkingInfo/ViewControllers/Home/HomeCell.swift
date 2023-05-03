//
//  HomeCell.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/13.
//

import UIKit
import SnapKit


class HomeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .contentColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(timeStampLabel)
        addSubview(stateLabel)
        addSubview(progressView)
        
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self).inset(20)
            $0.top.equalTo(self).inset(20)
            $0.trailing.equalTo(self.frame.width / 2)
        }
        
        timeStampLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }
        
        progressView.snp.makeConstraints {
            $0.bottom.equalTo(self).inset(20)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(self).inset(40)
            
        }
        
        stateLabel.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.bottom.equalTo(self)
            $0.width.equalTo(60)
            $0.height.equalTo(60)
        }
    
    }
    
    //MARK: UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    let stateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let stattedView: UIButton = {
        let view = UIButton()
        return view
    }()
    
    let timeStampLabel: UILabel = {
        let label = UILabel()
        //label.text = "2023-04-17 9:00"
        label.textColor = .lightGray
        return label
    }()
    
    let progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = .orange
        view.progress = 25
        view.trackTintColor = .lightGray
        view.backgroundColor = .white
        return view
    }()
    
    
}
