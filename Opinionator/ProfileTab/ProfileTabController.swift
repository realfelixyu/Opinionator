//
//  ProfileTabController.swift
//  Opinionator
//
//  Created by Felix Yu on 10/19/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class ProfileTabController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBlue
        navigationItem.title = "Profile"
    }

}
