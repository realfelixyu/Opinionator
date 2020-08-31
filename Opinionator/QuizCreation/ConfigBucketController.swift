//
//  ConfigBucketController.swift
//  Opinionator
//
//  Created by Felix Yu on 8/31/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class ConfigBucketController: UIViewController {
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    var quizManager: QuizCreationManager
    
    init(quizManager: QuizCreationManager) {
        self.quizManager = quizManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScrollView()
        loadStackView()
    }
    
    func loadScrollView() {
        
    }
    
    func loadStackView() {
        
    }
}
