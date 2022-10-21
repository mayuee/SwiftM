//
//  MDrawedViewController.swift
//  SwiftM
//
//  Created by mazb on 2022/10/21.
//

import UIKit

class MDrawedViewController: MBaseViewController {

    lazy var collectionView : UICollectionView = {
        
        let frame = view.bounds

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
    
    var dataArray : Array = Array<Any>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<20{
            dataArray.append(index)
        }

        collectionView.frame = view.bounds
        view.addSubview(collectionView)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .groupTableViewBackground
        return cell
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


