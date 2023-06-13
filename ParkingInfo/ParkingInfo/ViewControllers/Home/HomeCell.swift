//
//  HomeCell.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/13.
//

import UIKit
import SnapKit
import CircleProgressBar
import RxSwift


class HomeCell: UICollectionViewCell {
    
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .offWhite
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.cornerRadius = 18
        addSubview(titleLabel)
        
        addSubview(timeStampLabel)
        addSubview(parkingSeatLabel)
        addSubview(circleProgressBar)
        
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self).inset(20)
            $0.top.equalTo(self).inset(20)
            $0.width.equalTo(self.frame.width / 3 * 2)
        }
        
        
        timeStampLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
           
        }
        
        
        parkingSeatLabel.snp.makeConstraints {
            $0.top.equalTo(timeStampLabel.snp.bottom).offset(20)
            $0.leading.equalTo(timeStampLabel)
        }
        
        circleProgressBar.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.trailing.equalTo(self).inset(20)
            $0.top.equalTo(titleLabel)
        }
    
    }
    func configure(with model: Info) {
        titleLabel.text = model.parkinglotsTitle
        parkingSeatLabel.text = "남은 자리: \(model.empty)"
        timeStampLabel.text = model.timeStamp
        let progress = Double(model.total-model.empty) / Double(model.total)
        let progressObservable = Observable.just(progress)
        
        progressObservable
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] progress in
                self?.circleProgressBar.setProgress(progress, animated: true)
                
                if progress < 0.5 {
                    self?.circleProgressBar.progressBarProgressColor = .blueTitle
                    self?.circleProgressBar.progressBarTrackColor = .blueBackground
                } else if progress < 0.8 {
                    self?.circleProgressBar.progressBarProgressColor = .greenTitle
                    self?.circleProgressBar.progressBarTrackColor = .greenBackground
                } else {
                    self?.circleProgressBar.progressBarProgressColor = .redTitle
                    self?.circleProgressBar.progressBarTrackColor = .redBackground
                }
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        //label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    let timeStampLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    let parkingSeatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let circleProgressBar: CircleProgressBar = {
        let bar = CircleProgressBar()
        
//        let color1 = UIColor(red: 0.22, green: 0.42, blue: 0.99, alpha: 1.00)
//        let color2 = UIColor(red: 0.16, green: 0.28, blue: 1.00, alpha: 1.00)
//        let gradientColor = UIColor.createGradientColor(startColor: color1, endColor: color2, size: CGSize(width: 200, height: 200))
        //bar.progressBarProgressColor = .blueTitle
        bar.progressBarWidth = 20
        bar.hintTextFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        bar.hintTextColor = .black
        bar.hintViewBackgroundColor = .offWhite
        bar.backgroundColor = .offWhite
       // bar.progressBarTrackColor = .blueBackground
        
        return bar
    }()
    
    
}
