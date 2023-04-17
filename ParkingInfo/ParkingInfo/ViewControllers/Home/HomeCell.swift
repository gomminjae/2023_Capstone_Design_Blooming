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
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(stateLabel)
        
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self).inset(20)
            $0.trailing.equalTo(self.frame.width / 2)
        }
        
        
        
        
        
        
            
    }
    
    //MARK: UI
    let titleLabel: UILabel = {
        let label = UILabel()
        
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
        label.text = "2023-04-17 9:00"
        return label
    }()
    
    
}
