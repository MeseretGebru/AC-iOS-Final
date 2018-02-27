//
//  ForgotPasswordView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ForgotPasswordView: UIView {
        
        lazy var dismissButton: UIButton = {
            let butt = UIButton()
            butt.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
            butt.tintColor = .orange
            return butt
        }()
        
        lazy var emailTextField: UITextField = {
            let txt = UITextField()
            txt.placeholder = "Enter email"
            txt.autocapitalizationType = .none
            txt.borderStyle = .none
            underLine(from: txt)
            return txt
        }()
        
        lazy var resetLabel: UILabel = {
            let lab = UILabel()
            lab.text = "Reset your password here"
            lab.numberOfLines = 0
            lab.textColor = .orange
            return lab
        }()
        
        lazy var submitButton: UIButton = {
            let butt = UIButton()
            butt.setTitle("Submit", for: .normal)
            butt.backgroundColor = UIColor.orange
            return butt
        }()
        
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        private func commonInit() {
            backgroundColor = .white
            setupViews()
        }
        
        
        
        private func setupViews() {
            let views = [dismissButton,emailTextField, resetLabel, submitButton] as [UIView]
            views.forEach{ addSubview($0) }
            setUpDismissButt()
            setUpTF()
            setUpLabel()
            setUpSubButt()
        }
        
        private func setUpDismissButt() {
            dismissButton.snp.makeConstraints { (make) in
                make.top.equalTo(self.snp.top)
                make.left.equalTo(self.snp.left)
                make.size.equalTo(self.snp.size).multipliedBy(0.15)
                
            }
        }
        
        private func setUpTF() {
            emailTextField.snp.makeConstraints { (make) -> Void in
                make.centerX.equalTo(self.snp.centerX)
                make.centerY.equalTo(self.snp.centerY)
                make.width.equalTo(self.snp.width).multipliedBy(0.8)
                make.height.equalTo(self.snp.height).multipliedBy(0.1)
            }
        }
        
        private func setUpLabel() {
            resetLabel.snp.makeConstraints { (make) -> Void in
                make.centerX.equalTo(self.snp.centerX)
                make.centerY.equalTo(self.snp.centerY).offset(-70)
                make.width.equalTo(self.snp.width).multipliedBy(0.8)
                make.height.equalTo(self.snp.height).multipliedBy(0.1)
                
                
            }
            
        }
        
        private func setUpSubButt() {
            submitButton.snp.makeConstraints { (make) -> Void in
                make.centerY.equalTo(self.snp.centerY).offset(90)
                make.centerX.equalTo(self.snp.centerX)
                make.width.equalTo(self.snp.width).multipliedBy(0.8)
                make.height.equalTo(self.snp.height).multipliedBy(0.1)
                
                submitButton.layer.cornerRadius = 15
                submitButton.layer.masksToBounds = true
            }
        }
        
        func underLine(from txt: UITextField) {
            let border = UIView()
            border.backgroundColor = UIColor(displayP3Red: (229/255), green: (229/255), blue: (229/255), alpha: 1.0)
            border.translatesAutoresizingMaskIntoConstraints = false
            txt.addSubview(border)
            border.heightAnchor.constraint(equalToConstant: 1).isActive = true
            border.widthAnchor.constraint(equalTo: txt.widthAnchor).isActive = true
            border.bottomAnchor.constraint(equalTo: txt.bottomAnchor, constant: -1).isActive = true
            border.leftAnchor.constraint(equalTo: txt.leftAnchor).isActive = true
        }
        
}

