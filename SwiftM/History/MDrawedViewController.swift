//
//  MDrawedViewController.swift
//  SwiftM
//
//  Created by mazb on 2022/10/21.
//

import UIKit

class MDrawedViewController: MBaseViewController {

    lazy var collectionView : UICollectionView = {
        
        var frame = view.bounds
        
        if #available(iOS 11.0, *) {
            if let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets{
                frame = CGRect(x: safeAreaInsets.left, y: safeAreaInsets.top, width: frame.size.width-safeAreaInsets.left-safeAreaInsets.right, height: frame.size.height-safeAreaInsets.top-safeAreaInsets.bottom)
            }
        } else {
            // Fallback on earlier versions
        }

        let layout = MDrawedFlowLayout.init()
        let width = (frame.size.width-50)/4
        layout.itemSize = CGSize(width: (frame.size.width-50)/4, height: width * 0.6)
        //layout.footerReferenceSize = CGSize(width: screenWidth, height: 50)
        //layout.headerReferenceSize = CGSize(width: screenWidth, height: 50)
//        layout.itemSize = CGSizeMake((frame.size.width - flowLayout.margin)/2.0, 180);
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(MDrawedViewCell.classForCoder(), forCellWithReuseIdentifier: "kReuseIdentifier")
        //collectView.register(SwiftFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SwiftFooterCollectionReusableView")

        collectionView.backgroundColor = .white;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.scrollsToTop = false
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        return collectionView
        
    }()
    
    var dataArray : Array = Array<MHistoryModel>()

    var curIndex : Int = Int(MAXINTERP)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let array = MDBClient.shared.getHistoryList(){
            for ele in array {
                dataArray.append(ele)
            }
        }
        
        view.addSubview(collectionView)
    }
    
    private func deleteImage(){
        if curIndex < dataArray.count {
            let model = dataArray[curIndex]
            MFileManager.shared.deleteImage(named: model.createDate)
            MDBClient.shared.deleteHistory(model: model)
            dataArray.remove(at: curIndex)
            curIndex = Int(MAXINTERP)
            collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MDrawedViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "kReuseIdentifier"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MDrawedViewCell
        var m = dataArray[indexPath.row]
        cell.imageView.image = m.image
        cell.titleLabel.text = m.title
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var m = dataArray[indexPath.row]
        let pre = MImageViewController()
        pre.title = m.title
        pre.image = m.image
        curIndex = indexPath.row
        pre.deleteBlock = {()->Void in
            self.deleteImage()
        }
        self.navigationController?.pushViewController(pre, animated: true)
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView:SwiftHeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SwiftHeaderCollectionReusableView", for: indexPath) as! SwiftHeaderCollectionReusableView
        }
        else
            {
                let footerView:SwiftFooterCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SwiftFooterCollectionReusableView", for: indexPath) as! SwiftFooterCollectionReusableView
          return footerView
            }
    }
 */
    
}


