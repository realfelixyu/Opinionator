//
//  HomeController.swift
//  Opinionator
//
//  Created by Felix Yu on 8/22/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HomeController: UIViewController {
    var tempLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tempLabel.text = "need to implement home"
        
        view.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
