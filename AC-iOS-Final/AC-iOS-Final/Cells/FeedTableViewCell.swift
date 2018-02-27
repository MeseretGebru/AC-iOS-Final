//
//  FeedTableViewCell.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit
//import Kingfisher
import Firebase

class FeedTableViewCell: UITableViewCell {
    
    
    lazy var feedImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    lazy var commentLabel: UILabel = {
        let lab = UILabel()
        lab.font = UIFont(name: "Arial", size: 18)
        return lab
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "FeedCell")
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit() {
        setupViews()
        setupConstraint()
    }
    func setupViews() {
        addSubview(feedImageView)
        addSubview(commentLabel)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
  
    func setupConstraint() {
            feedImageView.snp.makeConstraints { (make) in
                make.top.equalTo(snp.top)
                make.centerX.equalTo(snp.centerX)
                make.width.equalTo(snp.width)
                make.bottom.equalTo(commentLabel.snp.top).offset(-8)
            }
       
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(feedImageView.snp.bottom).offset(8)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom).offset(-8)
        }
        
    }

    func configureCell(from post: Post) {
        let imageUrl = post.imageURL
        ImageService.manager.getImage(from: imageUrl) { (imageOnline) in
            if let image = imageOnline {
                self.feedImageView.image = image
                self.feedImageView.setNeedsLayout()
            }
        }
    }


}
