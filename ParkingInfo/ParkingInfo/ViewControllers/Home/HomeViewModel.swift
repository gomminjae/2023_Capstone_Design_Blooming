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
    
    var infos: Observable<[Info]> = APIService.shared.fetchPosts()
    
    

    
}
