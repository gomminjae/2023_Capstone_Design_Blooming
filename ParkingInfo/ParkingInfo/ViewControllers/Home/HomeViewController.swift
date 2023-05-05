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
        view.setGradient()
    
    }
    override func setupView() {
        view.addSubview(collectionView)
        
        setupNavBar()
        
    }
    
    private func setupNavBar() {
        let titleLabel = UILabel()
        titleLabel.text = " Blooming"
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        titleLabel.textColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
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
            cell.timeStampLabel.text = model.timeStamp
            cell.stateLabel.text = model.parkingState
            
            switch model.parkingState {
            case "full":
                cell.stateView.backgroundColor = .redBackground
                cell.stateLabel.textColor = .redTitle
            case "normal":
                cell.stateView.backgroundColor = .greenBackground
                cell.stateLabel.textColor = .greenTitle
            default:
                cell.stateView.backgroundColor = .blueBackground
                cell.stateLabel.textColor = .blueTitle
                
            }
        }.disposed(by: disposeBag)
    }
    
    //MARK
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 340, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        collectionView.backgroundColor = .clear
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reusableIdentifier)
        
        return collectionView
    }()
    
    

}

extension HomeViewController {
    private func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewLayout()
    }
}
