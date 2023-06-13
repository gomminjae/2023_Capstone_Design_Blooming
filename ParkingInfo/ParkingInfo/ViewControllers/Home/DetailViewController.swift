//
//  DetailViewController.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/06/07.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var parkinglotsTitle: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var info: Info?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetail()
        
        dismissButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        
    }
    
    private func setupDetail() {
        
        baseView.layer.cornerRadius = 20
        
        if let info = info {
            parkinglotsTitle.text = "\(info.parkinglotsTitle) 주차 현황"
            timestampLabel.text = info.timeStamp
            emptyLabel.text = "\(info.empty)자리 남았습니다."
            totalLabel.text = "총 \(info.total)"
        }
        
    }
    
}
