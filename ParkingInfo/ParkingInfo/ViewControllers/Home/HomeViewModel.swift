//
//  HomeViewModel.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/03.
//

import Foundation
import RxSwift
import RxCocoa
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import RxKakaoSDKUser
import RxKakaoSDKCommon
import RxKakaoSDKAuth
import RxDataSources


class HomeViewModel {
    private let disposeBag = DisposeBag()
    private let apiCallInterval: RxTimeInterval = .seconds(5)
    
    private let infosRelay = BehaviorRelay<[SectionModel<String, Info>]>(value: [])
    
    var infos: Driver<[SectionModel<String, Info>]> {
        return infosRelay.asDriver()
    }
    
    init() {
        fetchInfos()
        Observable<Int>.interval(apiCallInterval, scheduler: MainScheduler.instance)
            .startWith(0)
            .flatMapLatest { _ in InfoNetworkImpl.shared.fetchInfos().asObservable() }
            .map { [SectionModel(model: "Section", items: $0)] }
            .bind(to: infosRelay)
            .disposed(by: disposeBag)
    }
    
    private func fetchInfos() {
        InfoNetworkImpl.shared.fetchInfos()
            .map { [SectionModel(model: "Section", items: $0)] }
            .asDriver(onErrorJustReturn: [])
            .drive(infosRelay)
            .disposed(by: disposeBag)
    }
}





