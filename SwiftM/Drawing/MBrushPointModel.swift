//
//  MBrushPointModel.swift
//  SwiftM
//
//  Created by mazb on 2022/10/20.
//

import UIKit

class MBrushPointModel: NSObject {
    var color : UIColor? = .black
    var width : CGFloat = 3.0
    var point : CGPoint = CGPoint()
    
    convenience init(color : UIColor = .black, width : CGFloat = 3.0, point : CGPoint = CGPoint()) {
        self.init()
        self.color = color
        self.width = width
        self.point = point
    }
}
