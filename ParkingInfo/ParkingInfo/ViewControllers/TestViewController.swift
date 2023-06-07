//
//  TestViewController.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/05/27.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

//class TestCell: UICollectionViewCell {
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//}
//
//class TestViewController: BaseViewController {
//    
//    private let disposeBag: DisposeBag()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    override func setupView() {
//        view.addSubview(collectionView)
//    }
//    override func setupLayout() {
//        collectionView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.leading.equalTo(view)
//            $0.leading.equalTo(view)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
//    
//    
//    override func bindRx() {
//        let items = Observable<[String]>.just(["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"])
//        
//        // UICollectionView에 데이터를 바인딩
//        items.bind(to: collectionView.rx.items(cellIdentifier: "Cell")) { (row, element, cell) in
//            cell.textLabel?.text = element
//        }
//        .disposed(by: disposeBag)
//    }
//    
//
//    
//    let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        
//        return view
//    }()
//    
//    
//    
//
//}
//
//extension TestViewController {
//    
//    private func createLayout() -> UICollectionViewLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                              heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                               heightDimension: .absolute(100))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 10
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }
//}
