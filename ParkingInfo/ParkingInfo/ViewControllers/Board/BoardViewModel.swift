//
//  BoardViewModel.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/01.
//

import Foundation
import RxSwift
import RxCocoa

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
class BoardViewModel {
    
    private let disposeBag = DisposeBag()
    
    let selectedOption: BehaviorRelay<SegmentOption>

    let urlForLoad: BehaviorRelay<URL?>
    
    init() {
        selectedOption = BehaviorRelay<SegmentOption>(value: .seoul)
        urlForLoad = BehaviorRelay<URL?>(value: nil)
        
        selectedOption
            .subscribe(onNext: { [weak self] option in
                guard let self = self else { return }
                let url = self.generateURL(option)
                self.urlForLoad.accept(url)
            })
            .disposed(by: disposeBag)
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
    
    
}
