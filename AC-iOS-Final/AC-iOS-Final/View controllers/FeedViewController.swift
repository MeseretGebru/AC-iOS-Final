//
//  ViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q  on 2/22/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class FeedViewController: UIViewController {
    let firebaseAuth = Auth.auth()
    let feedView  = FeedView()
    
    // implement pageControl
    //lazy var width = view.safeAreaLayoutGuide.layoutFrame.width
    lazy var height = view.safeAreaLayoutGuide.layoutFrame.height
    let width = UIScreen.main.bounds.width
    // let height = UIScreen.main.bounds.height
    lazy var scrollView = UIScrollView(frame: CGRect(x:0, y: view.safeAreaLayoutGuide.layoutFrame.minY, width: width, height: height))
    var colors:[UIColor] = [UIColor.red, UIColor.blue]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    
    lazy var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:60,y: height, width: width / 2, height: 50))
    
    
    var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.feedView.tableView.reloadData()
            }
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        feedView.tableView.delegate = self
        feedView.tableView.dataSource = self
        // set scrollView delegate
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        setupScrollView()
        setUpScrollViewConstraints()
        configurePageControl()
        
    }
   
    private func loadData() {
        PostService.manager.getPosts { (posts) in
            self.posts = []
            self.posts = posts
        }
    }

    @objc func moreButtonPressed(sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let flagActionSheet = UIAlertAction(title: "Report", style: .default) {(action) in
            
        }
        
        let cancelActionSheet = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(flagActionSheet)
        alert.addAction(cancelActionSheet)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    private func setUpScrollViewConstraints() {
        scrollView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            
        }
    }
    
}

extension FeedViewController: UIScrollViewDelegate {
 
//    @objc func segmentValueChanged(sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 0 {
//            pageControl.currentPage = 0
//            frame.origin.x = self.scrollView.frame.size.width * CGFloat(0)
//            frame.size = self.scrollView.frame.size
//
//            let subView = UIView(frame: frame)
//            subView.addSubview(feedView)
//            //subView.backgroundColor = colors[0]
//            self.scrollView .addSubview(subView)
//
//            let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
//            scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
//        }
//        if sender.selectedSegmentIndex == 1 {
//            pageControl.currentPage = 1
//
//            frame.origin.x = self.scrollView.frame.size.width * CGFloat(1)
//            frame.size = self.scrollView.frame.size
//
//            let subView = UIView(frame: frame)
//           // subView.addSubview(popularFeedView)
//            // subView.backgroundColor = colors[1]
//            self.scrollView .addSubview(subView)
//
//            let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
//            scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
//        }
//    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        
        self.pageControl.numberOfPages = 2
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.green
        
        pageControl.addTarget(self, action: #selector(changePage(sender:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(pageControl)
    }
    
    
    func setupScrollView() {
        self.view.addSubview(scrollView)
        setUpScrollViewConstraints()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = true
        
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * 2, height: self.scrollView.frame.size.height)
        for index in 0...1 {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            
            let subView = UIView(frame: frame)
            // subView.backgroundColor = colors[index]
            switch index {
            case 0:
                subView.addSubview(feedView)
            default: break
                //subView.addSubview(popularFeedView)
                //subView.backgroundColor = .green
            }
            self.scrollView.addSubview(subView)
            
        }
    }
    
    @objc func changePage(sender: UIPageControl) -> () {
        
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        //segmentView.selectedSegmentIndex = pageControl.currentPage
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension FeedViewController: UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.layer.bounds.height * 0.40
       
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedTableViewCell {
            cell.layoutIfNeeded()
            let post = posts[indexPath.row]
            cell.configureCell(from: post)
            cell.setNeedsLayout()
            return cell
    }

    return UITableViewCell()
  }
}
