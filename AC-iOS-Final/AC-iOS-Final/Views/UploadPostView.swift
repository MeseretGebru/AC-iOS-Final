//
//  NewPostView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class UploadPostView: UIScrollView {
    
    private let fontSize: CGFloat = 30
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
   
  
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor.gray
        return image
    }()
    
    lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "camera_icon"), for: .normal)
        return button
    }()
    
    lazy var commentTextView: UITextView = {
        let text = UITextView()
        text.text = " add comment here..."
        text.textColor = UIColor.lightGray
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.borderWidth = 2
        text.font = UIFont.systemFont(ofSize: fontSize / 1.3)
        return text
    }()
    
    // MARK:- Subviews
    private func setupViews(){
    addSubview(imageView)
    addSubview(addImageButton)
    addSubview(commentTextView)
    }
    
    // MARK:- Constraints
    private func setupConstraints() {
       
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(snp.width)
            make.top.equalTo(snp.top)
            make.centerX.equalTo(snp.centerX)
        }
        
        
        addImageButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerY.equalTo(imageView.snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
        
        
        commentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width)
            make.bottom.equalTo(snp.bottom).offset(-16)
        }
    }
    
}
