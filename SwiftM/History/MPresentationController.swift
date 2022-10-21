//
//  MPresentationController.swift
//  SwiftM
//
//  Created by mazb on 2022/10/21.
//

import UIKit

class MPresentationController: UIPresentationController {
    
    var presentFrame : CGRect = CGRect.zero
    
    private lazy var coverView  = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        //
        presentedView?.frame = presentFrame
        
        //添加蒙层
        setupCoverView()
    }
}

extension MPresentationController{
    private func setupCoverView(){
        containerView?.insertSubview(coverView, at: 0)
        
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
        
        //添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tap)
    }
    
    @objc func coverViewClick(){
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}
