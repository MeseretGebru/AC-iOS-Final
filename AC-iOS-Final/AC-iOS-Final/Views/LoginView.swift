//
//  LoginView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//
import UIKit


class LoginView: UIView {
   
    lazy var emailTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "email"
        txt.autocapitalizationType = .none
        txt.borderStyle = .none
        txt.autocorrectionType = .no
        underLine(from: txt)
        return txt
    }()
    
    lazy var passwordTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Password"
        txt.borderStyle = .none
        txt.isSecureTextEntry = true
        txt.autocapitalizationType = .none
        underLine(from: txt)
        return txt
    }()
    
    lazy var submitInfoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    lazy var forgotPWButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
        button.backgroundColor = .orange
        return button
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
        setUpUserNameTextField()
        setUpPassWordTextField()
        setUpSubmitButton()
        setUpForgotPSWButton()
        
    }
    
    private func setupViews() {
        let views = [emailTextField, passwordTextField, submitInfoButton, forgotPWButton] as [UIView]
        views.forEach { addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
    }
    
    private func setUpUserNameTextField () {
        emailTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.9)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(self).offset(50)
            make.centerX.equalTo(self)
        }
    }
    
    private func setUpPassWordTextField () {
        passwordTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.9)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
    }
    
    private func setUpSubmitButton () {
        submitInfoButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.3)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            
            submitInfoButton.layer.cornerRadius = 15
            submitInfoButton.layer.masksToBounds = true
        }
        
    }
    
    private func setUpForgotPSWButton() {
        forgotPWButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self).multipliedBy(0.45)
            make.height.equalTo(self).multipliedBy(0.1)
            make.top.equalTo(submitInfoButton.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            
            forgotPWButton.layer.cornerRadius = 15
            forgotPWButton.layer.masksToBounds = true
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
