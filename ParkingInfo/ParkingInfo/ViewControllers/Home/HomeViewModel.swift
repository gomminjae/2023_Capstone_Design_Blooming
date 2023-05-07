//
//  HomeViewModel.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/03.
//

import Foundation
import RxSwift
import RxCocoa


protocol HomeViewModelBindable {
    
    associatedtype Input
    associatedtype Output
    
    
}

class HomeViewModel {
    
    var infos: Observable<[Info]> = InfoNetworkImpl.shared.fetchPosts()
    
    var dummy: Observable<[Info]> = Observable.of([
        Info(parkinglotsTitle: "조선대 IT 교수용 주차장", parkingState: "full", timeStamp: "2023-03-22 09:00"),
        Info(parkinglotsTitle: "조선대 IT 서쪽 주차장", parkingState: "free", timeStamp: "2023-03-22 09:00"),
        Info(parkinglotsTitle: "조선대 IT 동쪽 주차장", parkingState: "normal", timeStamp: "2023-03-22 09:00"),
        Info(parkinglotsTitle: "조선대 법대 주차장", parkingState: "full", timeStamp: "2023-03-22 09:00"),
        Info(parkinglotsTitle: "조선대 본관 남쪽 주차장", parkingState: "free", timeStamp: "2023-03-22 09:00"),
        Info(parkinglotsTitle: "조선대 본관 서쪽 주차장", parkingState: "normal", timeStamp: "2023-03-22 09:00"),
        Info(parkinglotsTitle: "조선대 미대 주차장", parkingState: "full", timeStamp: "2023-03-22 09:00")
    ])

    
}
