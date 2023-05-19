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
        self.delegate = self
    
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
            cell.timeStampLabel.text = model.timeStamp
            cell.stateLabel.text = model.parkingState
            
            switch model.parkingState {
            case "Full":
                cell.stateView.backgroundColor = .redBackground
                cell.stateLabel.textColor = .redTitle
            case "Normal":
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
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        collectionView.backgroundColor = .clear
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reusableIdentifier)
        
        return collectionView
    }()
    
    

}

extension HomeViewController {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

       if(velocity.y>0) {
           //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
           UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
               self.navigationController?.setNavigationBarHidden(true, animated: true)
               self.navigationController?.setToolbarHidden(true, animated: true)
               print("Hide")
           }, completion: nil)

       } else {
           UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
               self.navigationController?.setNavigationBarHidden(false, animated: true)
               self.navigationController?.setToolbarHidden(false, animated: true)
               print("Unhide")
           }, completion: nil)
         }
      }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
                changeTabBar(hidden: true, animated: true)
            }else{
                changeTabBar(hidden: false, animated: true)
            }

        }

    func changeTabBar(hidden:Bool, animated: Bool){
            let tabBar = self.tabBarController?.tabBar
            if tabBar!.isHidden == hidden{ return }
            let frame = tabBar?.frame
            let offset = (hidden ? (frame?.size.height)! : -(frame?.size.height)!)
            let duration:TimeInterval = (animated ? 0.5 : 0.0)
            tabBar?.isHidden = false
            if frame != nil
            {
                UIView.animate(withDuration: duration,
                                           animations: {tabBar!.frame = frame!.offsetBy(dx: 0, dy: offset)},
                                           completion: {
                                            print($0)
                                            if $0 {tabBar?.isHidden = hidden}
                })
            }
        }
}

