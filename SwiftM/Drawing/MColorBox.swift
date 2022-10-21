//
//  MColorBox.swift
//  SwiftM
//
//  Created by mazb on 2022/10/20.
//

import UIKit

class MColorBox: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
