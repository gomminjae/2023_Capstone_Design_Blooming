//
//  HeaderView.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/13.
//

import UIKit
import SnapKit

class HeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(baseView)
        
        baseView.snp.makeConstraints {
            $0.top.equalTo(self).inset(20)
            $0.leading.equalTo(self).inset(20)
            $0.trailing.equalTo(self).inset(20)
            $0.bottom.equalTo(self).inset(20)
        }
    }
    
    //MARK: UI
    let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .black 
        return view
    }()
}
