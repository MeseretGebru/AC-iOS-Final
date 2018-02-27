//
//  LoginViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuthUI

class LoginViewController: UIViewController {
    
        var activeTextField: UITextField = UITextField()
        
        let loginView = LoginView()
        let signUpView = SignUpView()
        let viewContainer = SegmentedControlView()
        private var authUserService = AuthUserService()
        var verificationTimer: Timer = Timer() //For email verification
    
        lazy var logoImage: UIImageView = {
            let image = UIImageView()
            image.image = #imageLiteral(resourceName: "meatly_logo")
            image.contentMode = .scaleAspectFit
            image.backgroundColor = .white
            return image
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            loginView.emailTextField.delegate = self
            loginView.passwordTextField.delegate = self
            signUpView.usernameTextField.delegate = self
            signUpView.emailTextField.delegate = self
            signUpView.passwordTextField.delegate = self
            authUserService.delegate = self
            //To check if user is already logged in.
            if Auth.auth().currentUser != nil {
                let destinationVC = TabBarController()
                present(destinationVC, animated: true, completion: nil)
                //navigationController?.pushViewController(destinationVC!, animated: true)
                
            }
            
            
            let views = [viewContainer, loginView, signUpView, logoImage] as [UIView]
            
            views.forEach{ ($0).translatesAutoresizingMaskIntoConstraints = false; self.view.addSubview($0) }
            signUpView.isHidden = true
            viewContainer.segmentedControl.selectedSegmentIndex = 0
            viewContainer.segmentedControl.addTarget(self, action: #selector(segmentControlPressed), for: .valueChanged)
            viewContainer.segmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.green], for: .selected)
            
            
            //For buttons
            loginView.submitInfoButton.addTarget(self, action: #selector(login), for: .touchUpInside)
            signUpView.createAccountButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
            loginView.forgotPWButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
//            signUpView.uploadImageButton.addTarget(self, action: #selector(getImageFromUser), for: .touchUpInside)
            
            //        self.verificationTimer = Timer.scheduledTimer(timeInterval: 200, target: self, selector: #selector(UserLogInVC.signUp) , userInfo: nil, repeats: true)
            
            setUpAccountView()
            signUpViewConstraints()
            createAccountConstraints()
            setUpLogoConstraints()
            
            NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            
            
        }
        
        @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    
                    let bottomOfTextField = activeTextField.frame.maxY + loginView.frame.origin.y
                    let newBottomOfScreen = view.frame.maxY - keyboardSize.height
                    print(bottomOfTextField)
                    print(newBottomOfScreen)
                    if bottomOfTextField > newBottomOfScreen {
                        let amountToShiftUp = bottomOfTextField - newBottomOfScreen
                        self.view.snp.remakeConstraints({ (make) in
                            make.top.equalTo(0).offset(-amountToShiftUp)
                            make.leading.equalTo(0)
                            make.width.equalTo(UIScreen.main.bounds.width)
                            make.height.equalTo(UIScreen.main.bounds.height)
                            make.bottom.equalTo(UIScreen.main.bounds.height).offset(-amountToShiftUp)
                        })
                        
                        // TODO:- fix this part, not working
                        UIView.animate(withDuration: 10, animations: {
                            self.view.updateConstraints()
                            self.view.layoutIfNeeded()
                        })
                    }
                }
            }
        }
        
        @objc func keyboardWillHide(notification: NSNotification) {
            if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    view.snp.remakeConstraints({ (make) in
                        let screenRect = UIScreen.main.bounds
                        make.top.equalTo(0)
                        make.leading.equalTo(0)
                        make.width.equalTo(screenRect.width)
                        make.height.equalTo(screenRect.height)
                    })
                }
            }
        }
        
        
        @objc private func login() {
            guard let email = loginView.emailTextField.text else { self.alertForErrors(with: "Please enter an email."); return }
            guard !email.isEmpty else { self.alertForErrors(with: "Please enter an email."); return }
            guard let password = loginView.passwordTextField.text else { self.alertForErrors(with: "Please enter a password."); return }
            guard !password.isEmpty else { self.alertForErrors(with: "Please enter a password."); return }
            
            authUserService.signIn(email: email, password: password)
        }
        
        @objc private func signUp() {
            guard let userName = signUpView.usernameTextField.text else {  self.alertForErrors(with: "Please enter a valid user name."); return }
            guard !userName.isEmpty else { self.alertForErrors(with: "Please enter a valid user name."); return }
            guard let email = signUpView.emailTextField.text else { self.alertForErrors(with: "Please enter an email."); return }
            guard !email.isEmpty else { self.alertForErrors(with: "Please enter a valid email."); return }
            guard let password = signUpView.passwordTextField.text else { self.alertForErrors(with: "Password is nil "); return }
            guard !password.isEmpty else { self.alertForErrors(with: "Password field is empty"); return }
            
            authUserService.createUser(email: email, password: password)
            
            
        }
        
        @objc private func reset() {
            let resetVC = ForgotPasswordVC()
            resetVC.modalTransitionStyle = .coverVertical
            resetVC.modalPresentationStyle = .pageSheet
            self.present(ForgotPasswordVC(), animated: true, completion: nil)
        }
        
        
        @objc private func getImageFromUser() {
            let addImageActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let openGallery = UIAlertAction(title: "Take Image From Library", style: .default) { [weak self] (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .photoLibrary;
                    imagePicker.allowsEditing = false
                    self?.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            //addImageActionSheet.addAction(openCamera)
            addImageActionSheet.addAction(openGallery)
            addImageActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil) )
            self.present(addImageActionSheet, animated: true, completion: nil)
            
        }
        
        func setUpLogoConstraints() {
            logoImage.snp.makeConstraints { (make) in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.width.equalTo(view.snp.width)
                make.centerX.equalTo(view)
                make.bottom.equalTo(viewContainer.snp.top)
            }
        }
        
        func setUpAccountView() {
            viewContainer.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(view.snp.height).multipliedBy(0.6)
                make.width.equalTo(view.snp.width)
                make.centerX.equalTo(view.snp.centerX)
                make.bottom.equalTo(view.snp.bottom)
                
            }
        }
        
        func signUpViewConstraints() {
            signUpView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(viewContainer.segmentedControl.snp.bottom)
                make.width.equalTo(viewContainer.snp.width)
                make.bottom.equalTo(view.snp.bottom)
                make.centerX.equalTo(viewContainer.segmentedControl.snp.centerX)
            }
        }
        
        func createAccountConstraints() {
            loginView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(viewContainer.segmentedControl.snp.bottom)
                make.width.equalTo(viewContainer.snp.width)
                make.bottom.equalTo(view.snp.bottom)
                make.centerX.equalTo(viewContainer.segmentedControl.snp.centerX)
                
            }
        }
        
        
        public func alertForErrors(with message: String) {
            let ac = UIAlertController(title: "Problem Logging In", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            ac.addAction(okAction)
            self.present(ac, animated: true, completion: nil)
        }
        
        @objc func segmentControlPressed(sender: UISegmentedControl)  {
            activeTextField.resignFirstResponder()
            if sender.selectedSegmentIndex == 0 {
                loginView.isHidden = false
                signUpView.isHidden = true
                print("\(String(describing: sender.titleForSegment(at: 0)))")
                sender.backgroundColor = UIColor(displayP3Red: (229/255), green: (229/255), blue: (229/255), alpha: 1.0)
                
            }
                
            else if sender.selectedSegmentIndex == 1 {
                loginView.isHidden = true
                signUpView.isHidden = false
                print("\(String(describing: sender.titleForSegment(at: 1)))")
                sender.backgroundColor = UIColor(displayP3Red: (229/255), green: (229/255), blue: (229/255), alpha: 1.0)
                
                
            }
        }
    }
    
    extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
           // if let profileImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                //self.signUpView.uploadImageButton.setImage(profileImage, for: .normal)
               // self.userProfileImage.image = profileImage
            }
            //picker.dismiss(animated: true, completion: nil)
        }
    //}
    
    extension LoginViewController: UITextFieldDelegate {
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.activeTextField = textField
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}



extension LoginViewController: AuthUserServiceDelegate {
    
    // Create user
    func didCreateUser(_ userService: AuthUserService, user: User) {
        let ac = UIAlertController(title: "Email Verification Sent", message: "Email verification is needed. Please check your email and follow the instructions.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.loginView.isHidden = false
            self.signUpView.isHidden = true
            self.viewContainer.segmentedControl.selectedSegmentIndex = 0
            self.signUpView.usernameTextField.text = ""
            self.signUpView.emailTextField.text = ""
            self.signUpView.passwordTextField.text = ""
            //self.signUpView.uploadImageButton.setImage(#imageLiteral(resourceName: "profile64"), for: .normal)
        })
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: {
//            if let userImage = self.userProfileImage.image {
//                UserService.manager.saveNewUser(imageProfile: userImage)
//            }
        })
    }
    
    func didFailCreatingUser(_ userService: AuthUserService, error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errorCode {
            case .invalidEmail:
                message = "Please enter a valid email"
            case .networkError:
                message = "There was an error with your connection. Please try again later."
            case .emailAlreadyInUse:
                message = "There is already an account associated with this email."
            case .missingEmail:
                message = "Email textfield empty. Please input a valid email."
            default:
                break
            }
            self.alertForErrors(with: message)
        }
    }
    
    func didFailToEmailVerify() {
        let message = "Please verify your E-mail."
        self.alertForErrors(with: message)
    }
    
    // SignIn
    func didFailToSignIn(_ userService: AuthUserService, error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            //Take message for each case and put in a string to use for alert.
            var message = ""
            switch errorCode {
            case .wrongPassword:
                message = "Wrong password entered."
            case .userNotFound:
                message = "User not found. Please check that you entered the correct name and password."
            case .invalidEmail:
                message = "Please enter a valid email"
            case .networkError:
                message = "There was an error with your connection. Please try again later."
            default:
                break
            }
            self.alertForErrors(with: message)
        }
    }
    
    func didSignIn(_ userService: AuthUserService, user: User) {
        
        let destinationVC = TabBarController()
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    // SignOut
    func didFailSigningOut(_ userService: AuthUserService, error: Error) {
        
    }
    
    func didSignOut(_ userService: AuthUserService) {
        
    }
}




