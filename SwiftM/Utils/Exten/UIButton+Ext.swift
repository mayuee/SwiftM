//
//  UIButton+Ext.swift
//  SwiftM
//
//  Created by mazb on 2022/10/19.
//

import UIKit

extension UIButton {
    
    ///convenience 便利构造函数，对系统类扩展构造函数使用，便利构造函数中需要         self.init()

    public convenience init(imageName: String) {
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        
    }
}
