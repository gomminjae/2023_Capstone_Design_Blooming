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
        title = "게시판"

        // Do any additional setup after loading the view.
    }
    
    override func setupView() {
        
    }
    
    override func setupLayout() {
    
    }
    
    override func bindRx() {
        
    }
    
    
    //MARK: UI
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    let floatingButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    
    

}
