//
//  BucketConfigurationController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/3/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class BucketConfigurationController: UIViewController {
    
    var sliders = [UISlider(), UISlider(), UISlider(), UISlider()]
    var bucketsData: [[[Double]]]
    var questionIndex: Int
    var answerIndex: Int
    
    var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    init(questionIndex: Int, answerIndex: Int, bucketsData: [[[Double]]]) {
        self.bucketsData = bucketsData
        self.questionIndex = questionIndex
        self.answerIndex = answerIndex
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureSliders()
    }
    
    func configureSliders() {
        for (index, slider) in sliders.enumerated() {
            
            slider.minimumValue = -100
            slider.maximumValue = 100
            slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
            stack.addArrangedSubview(slider)
        }
    }
    
    @objc func handleSliderChange(slider: UISlider) {
        
    }
}
