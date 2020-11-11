//
//  QuizResultController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/10/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class QuizResultController: UIViewController {
    
    var result: String
    
    private let resultTextView = UITextView(frame: CGRect(x: 20, y: getTopSafeAreaHeight() + 70, width: UIScreen.main.bounds.width - 40, height: 200))
    
    init(result: String) {
        self.result = result
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.basicColors.teal
        configureTextView()
    }
    
    func configureTextView() {
        resultTextView.text = result
        resultTextView.font = UIFont.systemFont(ofSize: 30)
        resultTextView.textAlignment = .center
        resultTextView.textColor = .black
        resultTextView.backgroundColor = .white
        resultTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        resultTextView.layer.cornerRadius = 20
        resultTextView.centerVertically()
        view.addSubview(resultTextView)
    }
}
