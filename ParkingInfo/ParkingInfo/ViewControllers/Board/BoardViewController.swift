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
enum SegmentOption: Int {
    case seoul
    case gwangju
    case incheon
    
    var cityName: String {
        switch self {
        case .seoul: return "서울"
        case .gwangju: return "광주"
        default: return "인천 미추홀"
        }
    }
}

class BoardViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    

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
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view).inset(20)
            $0.trailing.equalTo(view).inset(20)
            $0.height.equalTo(60)

        }
        webView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(view)
        }
    
    }
    
    override func bindRx() {
        
        let selectedOption = BehaviorRelay<SegmentOption>(value: .seoul)
        
        selectedOption
            .subscribe(onNext: { [weak self] option in
                guard let self = self else { return }
                if let url = self.generateURL(option) {
                    let request = URLRequest(url: url)
                    self.webView.load(request)
                }
            })
            .disposed(by: disposeBag)
        
        segmentedControl.rx.selectedSegmentIndex
            .map { SegmentOption(rawValue: $0) }
            .compactMap { $0 }
            .bind(to: selectedOption)
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
    
    private func generateURL(_ option: SegmentOption) -> URL? {
        var urlString: String
        
        switch option {
        case .seoul:
            urlString = "https://parking.seoul.go.kr/#"
        case .gwangju:
            urlString = "https://www.gjtic.go.kr/parking"
        default:
            urlString = "https://parking.incheon.go.kr/"
        }
        
        return URL(string: urlString)
    }
    
    
    //MARK: UI
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.selectedSegmentIndex = 0
        return control
      }()
    
    let webView: WKWebView = {
        let view = WKWebView()
        return view
    }()
    
    
    
    
    
    

}
