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
        self.backgroundColor = .offWhite
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.cornerRadius = 15
        addSubview(titleLabel)
        
        addSubview(stateView)
        addSubview(starredView)
        addSubview(timeStampLabel)
        stateView.addSubview(stateLabel)
        
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self).inset(20)
            $0.top.equalTo(self).inset(20)
            $0.width.equalTo(self.frame.width / 3 * 2)
        }
        
        starredView.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.trailing.equalTo(self).inset(10)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(40)
            $0.bottom.equalTo(titleLabel)
        }
        
        timeStampLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        stateView.snp.makeConstraints {
            $0.top.equalTo(timeStampLabel.snp.bottom).offset(10)
            $0.trailing.equalTo(starredView.snp.trailing)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.bottom.equalTo(self).inset(20)
            
        }
        
        stateLabel.snp.makeConstraints {
            $0.top.equalTo(stateView)
            $0.trailing.equalTo(stateView)
            $0.leading.equalTo(stateView)
            $0.bottom.equalTo(stateView)
        }
    
    }
    
    //MARK: UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        //label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    let stateView: UIView = {
        let view = UIView()
        view.backgroundColor = .redBackground
        view.layer.cornerRadius = 15
        return view
    }()
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .redTitle
        label.text = "Full"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let starredView: UIButton = {
        let button = UIButton()
        //button.backgroundColor = .red
        button.setImage(UIImage(named: "star.fill"), for: .normal)
        return button
    }()
    
    let timeStampLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .redBackground
        //label.text = "2023-04-17 9:00"
        label.textColor = .redTitle
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
}
