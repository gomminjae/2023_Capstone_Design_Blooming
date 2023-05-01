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

class BoardViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: UI
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    

}
