//
//  HSUnderLineTextField.swift
//  Opinionator
//
//  Created by Felix Yu on 8/22/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class HSUnderLineTextField: UITextField , UITextFieldDelegate {

    let border = CALayer()
    let lineColor: UIColor
    let lineHeight: CGFloat
    let selectedLineColor: UIColor

//    @IBInspectable open var lineColor : UIColor = UIColor.black {
//        didSet{
//            border.borderColor = lineColor.cgColor
//        }
//    }
//
//    @IBInspectable open var selectedLineColor : UIColor = UIColor.black {
//        didSet{
//        }
//    }
//
//
//    @IBInspectable open var lineHeight : CGFloat = CGFloat(1.0) {
//        didSet{
//            border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
//        }
//    }
    
    init(lineColor: UIColor, lineHeight: CGFloat, selectedLineColor: UIColor, frame: CGRect) {
        self.lineHeight = lineHeight
        self.lineColor = lineColor
        self.selectedLineColor = selectedLineColor
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init?(coder aDecoder: (NSCoder?)) {
//        super.init(coder: aDecoder!)
//        self.delegate=self;
//        border.borderColor = lineColor.cgColor
//        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
//                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
//
//
//        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
//        border.borderWidth = lineHeight
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }

    override func draw(_ rect: CGRect) {
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        self.delegate = self
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        border.borderColor = selectedLineColor.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        border.borderColor = lineColor.cgColor
    }
}
