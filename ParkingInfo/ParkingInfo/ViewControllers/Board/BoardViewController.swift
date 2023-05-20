//
//  BoardViewController.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/01.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import WebKit

/*MARK: URL: 광주: https://www.gjtic.go.kr/parking
 서울: https://parking.seoul.go.kr/#
 인천: https://parking.incheon.go.kr/
*/ 

class BoardViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = BoardViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentControl()
        view.setGradient()
        title = nil

        // Do any additional setup after loading the view.
    }
    
    override func setupView() {
        view.addSubview(segmentedControl)
        view.addSubview(webView)
        
    }
    
    override func setupLayout() {
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalTo(view).inset(20)
            $0.trailing.equalTo(view).inset(20)
            $0.height.equalTo(40)

        }
        webView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(view)
        }
    
    }
    
    override func bindRx() {
        
        segmentedControl.rx.selectedSegmentIndex
            .map { SegmentOption(rawValue: $0) }
            .compactMap { $0 }
            .bind(to: viewModel.selectedOption)
            .disposed(by: disposeBag)
        
        viewModel.urlForLoad
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] url in
                guard let self = self else { return }
                let request = URLRequest(url: url)
                self.webView.load(request)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupSegmentControl() {
        
        let cities = [SegmentOption.seoul,SegmentOption.gwangju,SegmentOption.incheon]
        segmentedControl.removeAllSegments()
        
        for (idx, city) in cities.enumerated() {
            segmentedControl.insertSegment(withTitle: city.cityName, at: idx, animated: true)
        }
        segmentedControl.selectedSegmentIndex = 0
    }
    
    
    
    //MARK: UI
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.selectedSegmentIndex = 0
        control.backgroundColor = .blueBackground
        control.layer.borderWidth = 0.8
        control.layer.borderColor = UIColor.offWhite.cgColor
        control.selectedSegmentTintColor = .offWhite
        control.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .normal)
        return control
      }()
    
    let webView: WKWebView = {
        let view = WKWebView()
        return view
    }()
    
    
    
    
    
    

}
