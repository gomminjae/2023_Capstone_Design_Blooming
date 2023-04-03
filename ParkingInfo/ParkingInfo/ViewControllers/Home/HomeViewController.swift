//
//  HomeViewController.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/03/31.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa

class HomeViewController: BaseViewController {
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "State"
        // Do any additional setup after loading the view.
    }
    override func setupView() {
        view.addSubview(collectionView)
    }
    
    override func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(view)
        }
    }
    
    
    //MARK
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor =  .systemMint
        return view
    }()
    

}
