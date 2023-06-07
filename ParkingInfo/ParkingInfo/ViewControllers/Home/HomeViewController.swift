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
    
    weak var delegate: UIScrollViewDelegate?

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
        viewModel.infos.bind(to: collectionView.rx.items(cellIdentifier: HomeCell.reusableIdentifier, cellType: HomeCell.self)) { index,model,cell in
            cell.titleLabel.text =  model.parkinglotsTitle
            //cell.timeStampLabel.text = model.timeStamp
            cell.parkingSeatLabel.text = "\(model.empty)/\(model.total)"
            let progress = Double(model.empty) / Double(model.total)
            cell.circleProgressBar.setProgress(progress, animated: true)
            cell.configure(with: model)
            
        }.disposed(by: disposeBag)
        
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
