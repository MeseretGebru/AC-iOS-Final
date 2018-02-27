//
//  SegmentedControlView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class SegmentedControlView: UIView {
    
    lazy var segmentedControl: UISegmentedControl = {
        let segCon = UISegmentedControl(items: ["Log In", "Create Account"])
        segCon.tintColor = UIColor.lightGray
        
        segCon.backgroundColor = UIColor(displayP3Red: (229/255), green: (229/255), blue: (229/255), alpha: 1.0)
        return segCon
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
        backgroundColor = .blue
        setupViews()
        //        configure()
    }
    
    private func setupViews() {
        let views = [segmentedControl] as [UIView]
        views.forEach { addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        setUpSegCon()
        //        setUpUserView()
        
    }
    
    private func setUpSegCon() {
        segmentedControl.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.2)
            make.centerX.equalTo(self)
            //            make.centerY.equalTo(self)
            make.top.equalTo(self)
        }
     
    }
  
}




