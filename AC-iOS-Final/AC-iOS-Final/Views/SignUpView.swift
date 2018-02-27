//
//  SignUpView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SignUpView: UIView {

    lazy var usernameTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Username"
        txt.autocapitalizationType = .none
        txt.autocorrectionType = .no
        underLine(from: txt)
        return txt
    }()
    
    lazy var emailTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Email Address"
        txt.autocapitalizationType = .none
        txt.autocorrectionType = .no
        underLine(from: txt)
        return txt
    }()
    
    lazy var passwordTextField: UITextField  = {
        let txt = UITextField()
        txt.placeholder = "Password"
        txt.autocapitalizationType = .none
        txt.autocorrectionType = .no
        txt.isSecureTextEntry = true
        underLine(from: txt)
        return txt
    }()
    
    lazy var createAccountButton: UIButton = {
        let butt = UIButton()
        butt.setTitle("Sign Up", for: .normal)
        butt.backgroundColor = .orange
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
        let views = [usernameTextField, emailTextField, passwordTextField, createAccountButton] as [UIView]
        views.forEach { ($0).translatesAutoresizingMaskIntoConstraints = false; addSubview($0)}
    
        setUpUserNameTextField()
        setUpEmailTextField()
        setUpPassWordTextField()
        setUpCreateButton()
        
    }

    
    
    private func setUpUserNameTextField() {
        usernameTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.9)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self)
        }
    }
    
    private func setUpEmailTextField() {
        emailTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.9)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            
        }
    }
    
    private func setUpPassWordTextField() {
        passwordTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.9)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
    }
    
    
    private func setUpCreateButton() {
        createAccountButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.3)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            
            
            createAccountButton.layer.cornerRadius = 15
            createAccountButton.layer.masksToBounds = true
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

