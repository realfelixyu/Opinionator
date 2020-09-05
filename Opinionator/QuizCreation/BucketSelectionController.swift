//
//  BucketSelectionController.swift
//  Opinionator
//
//  Created by Felix Yu on 8/22/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class BucketSelectionController: UIViewController, UITextFieldDelegate {
    var continueButton = UIButton()
    var addButton = UIButton()
    var removeButton = UIButton()
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    var textFields = [UITextField(), UITextField()]
    var lastTextFieldIndex = 1;
    //var textFieldArray = Array(repeating: UITextField(), count: 2)
    let cellId = "cellId"
    
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
        createScrollView()
        loadStackView()
        loadAddRemoveButton()
        loadContinueButton()
        view.backgroundColor = .white
    }
    
    func createScrollView() {
        scrollView.backgroundColor = .gray
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        navigationItem.title = "Select Buckets"
    }
    
    func loadStackView() {
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        stackView.spacing = 10
        loadTextFields()
    }
    
    func loadTextFields() {
        for textfield in textFields {
            textfield.backgroundColor = .white
            textfield.text = "test"
            textfield.borderStyle = UITextField.BorderStyle.roundedRect
            stackView.addArrangedSubview(textfield)
            textfield.snp.makeConstraints { (make) in
                make.width.equalTo(LayoutHelper.relativeWidth(percentOfScreen: 80))
                make.height.equalTo(LayoutHelper.relativeHeight(percentOfScreen: 8))
                make.margins.equalTo(10)
                make.centerX.equalToSuperview()
            }
        }
    }
    
    func loadAddRemoveButton() {
        addButton.setTitle("Add Category", for: .normal)
        addButton.backgroundColor = .systemTeal
        addButton.layer.cornerRadius = 15
        addButton.snp.makeConstraints { (make) in
            make.width.equalTo(LayoutHelper.pixelRelativeToScreen(toWidth: 300))
            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 50))
        }
        addButton.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
        stackView.addArrangedSubview(addButton)
    }
    
    func loadContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = UIColor.basicColors.teal
        continueButton.layer.cornerRadius = 15
        //continueButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        continueButton.addTarget(self, action: #selector(tappedContinueButton), for: .touchUpInside)
        stackView.addArrangedSubview(continueButton)
        continueButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 550))
            make.centerX.equalToSuperview()
            make.width.equalTo(LayoutHelper.pixelRelativeToScreen(toWidth: 50))
            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 50))
        }
    }
    
    @objc func tappedContinueButton(sender: UIButton!) {
        let bucketsArray = stackView.arrangedSubviews.compactMap { ($0 as? UITextField)?.text }
        quizManager.saveBuckets(buckets: bucketsArray)
        let questionAnswerVC = QuestionAnswerController(quizManager: quizManager)
        navigationController?.pushViewController(questionAnswerVC, animated: true)
    }
    
    @objc func tappedAddButton(sender: UIButton!) {
        let newTextField = UITextField()
        stackView.insertArrangedSubview(newTextField, at: lastTextFieldIndex)
        lastTextFieldIndex += 1
        newTextField.backgroundColor = .white
        newTextField.text = "test"
        newTextField.borderStyle = UITextField.BorderStyle.roundedRect
        newTextField.snp.makeConstraints { (make) in
            make.width.equalTo(LayoutHelper.relativeWidth(percentOfScreen: 80))
            make.height.equalTo(LayoutHelper.relativeHeight(percentOfScreen: 8))
            make.margins.equalTo(10)
            make.centerX.equalToSuperview()
        }
    }
    
    
}

//extension BucketSelectionController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//
//        let text = self.textFieldTexts[indexPath.row]
//
//
//        return cell
//    }
//}

//extension BucketSelectionController: UITextFieldDelegate {
//
//    func textFieldDidEndEditing(textField: UITextField) {
//
//    }
//}
