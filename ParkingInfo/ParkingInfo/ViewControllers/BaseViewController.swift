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
        setupNavBar()
        //view.backgroundColor = .baseColor
        
        //view.backgroundColor = .systemBlue

        // Do any additional setup after loading the view.
    }
    

    func setupView(){}
    func setupLayout() {}
    func bindRx() {}
    
    private func setupNavBar() {
        let titleLabel = UILabel()
        titleLabel.text = " Blooming"
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        titleLabel.textColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.backgroundColor = .offWhite
        //tabbarAppearance.configureWithTransparentBackground()
        tabBarController?.tabBar.standardAppearance = tabbarAppearance
        
    }

}
