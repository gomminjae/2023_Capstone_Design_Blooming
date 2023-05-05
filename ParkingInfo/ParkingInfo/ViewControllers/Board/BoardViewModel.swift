//
//  BoardViewModel.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/01.
//

import Foundation
import RxSwift
import RxCocoa

protocol BoardViewModelBindable {
    
    associatedtype Input
    associatedtype Output
    
}

class BoardViewModel {
    
    private let disposeBag = DisposeBag()
    
    init() {}
    
}
