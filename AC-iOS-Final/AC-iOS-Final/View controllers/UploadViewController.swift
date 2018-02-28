//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {
    var uploadView = UploadPostView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(uploadPost))
        uploadView.backgroundColor = UIColor.white
        
        setupViews()
        connectViewFunctions()
    }
    
    @objc private func uploadPost() {
        
        guard let image = uploadView.addImageButton.image(for: .normal) else {
            let noTitleAlert = UIAlertController(title: "No Image", message: "Please pick an image for your post before posting", preferredStyle: .alert)
            noTitleAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(noTitleAlert, animated: true, completion: nil)
            return
        }
        
        let comment = uploadView.commentTextView.text
        PostService.manager.saveNewPost(content: comment ?? "", image: image)
        // the alert view
        let alert = UIAlertController(title: "", message: "post is being uploaded", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    
    private func setupViews() {
        view.addSubview(uploadView)
        uploadView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    
    // MARK:- connect dataSources, delegates, and targets
    private func connectViewFunctions() {

        uploadView.commentTextView.delegate = self 
        uploadView.addImageButton.addTarget(self, action: #selector(addImageButtonPressed), for: .touchUpInside)
        
    }
    
    //
    
    @objc private func addImageButtonPressed() {
        let addImageActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let openGallery = UIAlertAction(title: "take from library", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = false
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        addImageActionSheet.addAction(openGallery)
        addImageActionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil) )
        self.present(addImageActionSheet, animated: true, completion: nil)
        
    }
    
}
// MARK: Camera and gallery stuff
extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.uploadView.imageView.image = pickedImage
            self.uploadView.addImageButton.isHidden = true
            self.uploadView.addImageButton.setTitle("", for: .normal)
            //updateImageViewSize()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
extension UploadViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        //        if textView == newPostView.titleTextView {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
        //        } else if textView == newPostView.descriptionTextView {
        //            if textView.textColor == .lightGray {
        //                textView.text = nil
        //                textView.textColor = .black
        //            }
        //        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == uploadView.commentTextView {
            if textView.text.isEmpty {
                textView.text = "enter comment)"
                textView.textColor = .lightGray
            }
        }
    }
}

