//
//  BaseViewController.swift
//  ParkingInfo
//
//  Created by 권민재 on 2023/04/02.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        bindRx()
        //view.backgroundColor = .baseColor
        
        //view.backgroundColor = .systemBlue

        // Do any additional setup after loading the view.
    }
    

    func setupView(){}
    func setupLayout() {}
    func bindRx() {}

}
