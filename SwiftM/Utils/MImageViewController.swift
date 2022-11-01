//
//  MImageViewController.swift
//  SwiftM
//
//  Created by mazb on 2022/11/1.
//

import UIKit

class MImageViewController: UIViewController {

    lazy var imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(gesture:)))
        tap.numberOfTapsRequired = 2
        imgView.addGestureRecognizer(tap)
        return imgView
    }()
    
    lazy var scrollView : UIScrollView = {
        
        var frame = view.bounds
        if #available(iOS 11.0, *) {
            if let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets{
                frame = CGRect(x: safeAreaInsets.left, y: safeAreaInsets.top, width: frame.size.width-safeAreaInsets.left-safeAreaInsets.right, height: frame.size.height-safeAreaInsets.top-safeAreaInsets.bottom)
            }
        }
        let sv = UIScrollView(frame: frame)
        sv.delegate = self
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.scrollsToTop = false
        sv.bounces = false
        
        sv.maximumZoomScale = 3.0
        sv.minimumZoomScale = 0.2
        
        return sv
    }()
    
    var zoomOut_In : Bool = true
    
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        loadSubViews()
    }
    
    private func loadSubViews(){
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        var frameToCenter = CGRect()

        if image != nil {
            imageView.image = image!
            frameToCenter = CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height)
        }
        
        let boundsSize = scrollView.bounds.size;
        if (frameToCenter.size.width > boundsSize.width) {
            let t = frameToCenter.size.height / frameToCenter.size.width
            frameToCenter.size.width = boundsSize.width
            frameToCenter.size.height = t * frameToCenter.size.width
        }
        
        if (frameToCenter.size.height > boundsSize.height) {
            let t = frameToCenter.size.width / frameToCenter.size.height
            frameToCenter.size.height = boundsSize.height
            frameToCenter.size.width = t * frameToCenter.size.height
        }

        // center horizontally
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        }else{
            frameToCenter.origin.x = 0.0
        }

        // center vertically
        if frameToCenter.size.height < boundsSize.height{
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        }else{
            frameToCenter.origin.y = 0.0
        }

        imageView.frame = frameToCenter
        scrollView.contentSize = imageView.frame.size
    }
    

    @objc func tapAction(gesture : UITapGestureRecognizer!){
        
        var toscale = 0;
        ////    var toscale = scrollView.zoomScale * 1.5;//zoomScale这个值决定了contents当前扩展的比例

        if (zoomOut_In) {
            toscale = 2;
            zoomOut_In = false;
        }else
        {
            toscale = 1;
            zoomOut_In = true;
        }
        let center = gesture.location(in: gesture.view)
        let zoomRect = calZoomRect(forScale: CGFloat(toscale), with: center)
        scrollView.zoom(to: zoomRect, animated: true)

    }
    
    private func calZoomRect(forScale scale : CGFloat, with center : CGPoint) -> CGRect{
        var zoomRect = CGRect()
        zoomRect.size.height = scrollView.frame.size.height / scale
        zoomRect.size.width = scrollView.frame.size.width / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
}

// MARK: - UIScrollViewDelegate
extension MImageViewController : UIScrollViewDelegate{
    //当UIScrollView尝试进行缩放的时候调用
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    //当缩放完毕的时候调用
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.setZoomScale(scale, animated: false)
    }
    //当正在缩放的时候调用
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let boundsSize = scrollView.bounds.size;
        var frameToCenter = imageView.frame;

        // center horizontally
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0.0
        }
        // center vertically
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0.0
        }
        imageView.frame = frameToCenter;
    }
}
