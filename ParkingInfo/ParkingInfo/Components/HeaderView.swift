//
//  HeaderView.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/13.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI
    let baseView: UIView = {
        let view = UIView()
        return view
    }()
}
