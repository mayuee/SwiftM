//
//  MBrushLine.swift
//  SwiftM
//
//  Created by mazb on 2022/10/20.
//

import UIKit

struct MBrushPoint {
    var point : CGPoint = CGPoint()
    var width : CGFloat = 3.0
}

class MBrushLine: NSObject {
    var color : UIColor = .black
    var cat : MBrushCat = .paint
    var points : Array = Array<MBrushPoint>()
    convenience init(color : UIColor = .black, cat : MBrushCat = .paint) {
        self.init()
        self.color = color
        self.cat = cat
    }
    
    func addPoint(point : MBrushPoint) {
        points.append(point)
    }
}
