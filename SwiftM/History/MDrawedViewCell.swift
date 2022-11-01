//
//  MDrawedViewCell.swift
//  SwiftM
//
//  Created by mazb on 2022/10/21.
//

import UIKit

class MDrawedViewCell: UICollectionViewCell {
    
    var imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.backgroundColor = .brown
        return imgView
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textAlignment = .center
        label.backgroundColor = .blue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .groupTableViewBackground
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 0, y: self.m_height-16, width: self.m_width, height: 16)
        imageView.frame = CGRect(x: 0, y: 0, width: self.m_width, height: titleLabel.m_top)
    }
}
