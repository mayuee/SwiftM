//
//  MBrush.swift
//  SwiftM
//
//  Created by mazb on 2022/10/20.
//

import UIKit

enum MBrushCat {
    case paint        //画笔
    case eraser        //橡皮擦
}

//struct MBrushs {
//    var color : UIColor
//    var width : CGFloat
//}

class MBrush: NSObject {
  
    var width : CGFloat  = 3.0

    var color : UIColor = .black
    
    var cat : MBrushCat = .paint
    
    convenience init(color : UIColor = .black, width : CGFloat = 3.0, cat : MBrushCat = .paint){
        self.init()
        self.color = color
        self.width = width
        self.cat = cat
        
    }
}
