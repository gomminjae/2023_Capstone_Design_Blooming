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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(stateLabel)
        
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
    
    let stattedView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
}
