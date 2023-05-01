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
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "주차장 현황"
        // Do any additional setup after loading the view.
    }
    override func setupView() {
        view.addSubview(collectionView)
        view.backgroundColor = .baseColor
        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .baseColor
        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.textColor]
    }
    
    override func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view)
            $0.trailing.equalTo(view)
            $0.bottom.equalTo(view)
        }
    }
    
    override func bindRx() {
        viewModel.dummyData.bind(to: collectionView.rx.items(cellIdentifier: HomeCell.reusableIdentifier, cellType: HomeCell.self)) { index,model,cell in
            cell.titleLabel.text = model.parkinlotsTitle
            
        }.disposed(by: disposeBag)
    }
    
    //MARK
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 340, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor =  .baseColor
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reusableIdentifier)
        
        return collectionView
    }()
    
    

}

extension HomeViewController {
    private func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewLayout()
    }
}
