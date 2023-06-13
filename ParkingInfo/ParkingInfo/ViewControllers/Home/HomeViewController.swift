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
import RxDataSources


class HomeViewController: BaseViewController, UIScrollViewDelegate {
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Info>>(
        configureCell: { dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reusableIdentifier, for: indexPath) as! HomeCell
            print("------>\(item)")
            cell.configure(with: item)
            return cell
        })
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradient()
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
    
    override func bindRx() {


        viewModel.infos
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
       



        collectionView.rx.modelSelected(Info.self)
            .subscribe(onNext: { item in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let detailVC = storyboard.instantiateViewController(identifier: "detail") as? DetailViewController {
                    detailVC.info = item
                    self.present(detailVC, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    //MARK
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 340, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
        collectionView.backgroundColor = .clear
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reusableIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reusableIdentifier)
        return collectionView
    }()
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, itemAt indexPath: IndexPath, didChangeTo newIndexPath: IndexPath?) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HomeCell {
            let item = dataSource[indexPath]
            cell.configure(with: item)
        }
    }
}
