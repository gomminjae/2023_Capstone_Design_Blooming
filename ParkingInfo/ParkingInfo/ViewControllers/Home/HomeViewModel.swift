//
//  HomeViewModel.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/03.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    var dummyData: Observable<[Info]> = Observable.of([
        Info(parkinlotsTitle: "조선대학교 IT 교수용 주차장", parkingState: "Full"),
        Info(parkinlotsTitle: "조선대학교 인문 사회대 주차장", parkingState: "Normal"),
        Info(parkinlotsTitle: "조선대학교 IT 일반 주차장", parkingState: "Full"),
        Info(parkinlotsTitle: "조선대학교 경상대 주차장", parkingState: "Peace"),
        Info(parkinlotsTitle: "조선대학교 해오름관 주차장", parkingState: "Peace"),
    ])
    
    

    
}
