//
//  LoginViewModel.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/03.
//

import Foundation
import RxSwift
import RxCocoa


protocol ViewModelType {
    var disposeBag: DisposeBag { get set }
    
    associatedtype Input
    associatedtype Output
}

class LoginViewModel {
    
    private let disposeBag = DisposeBag()
    
    
    
}
