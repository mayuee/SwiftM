//
//  UIView+Ext.swift
//  SwiftM
//
//  Created by mazb on 2022/10/20.
//

import UIKit

extension UIView{
    var m_left : CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.x = newValue
            frame = tmpFrame
        }
    }
    
    var m_top : CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.y = newValue
            frame = tmpFrame
        }
    }
    
    var m_width : CGFloat {
        get {
            return frame.size.width
        }
        set {
            var tmpFrame : CGRect = frame
            tmpFrame.size.width = newValue
            frame = tmpFrame
        }
    }
    
    var m_height : CGFloat {
        get {
            return frame.size.height
        }
        set {
            var tmpFrame : CGRect = frame
            tmpFrame.size.height = newValue
            frame = tmpFrame
        }
    }
    
    var m_bottom : CGFloat {
        get {
            return m_top + m_height
        }
        set {
            m_top = newValue - m_height
        }
    }
    
    var m_right : CGFloat {
        get {
            return m_left + m_width
        }
        set {
            m_left = newValue - m_width
        }
    }

    var m_centerX : CGFloat {
        get {
            return center.x
        }
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    
    var m_centerY : CGFloat {
        get {
            return center.y
        }
        set {
            center = CGPoint(x: center.x, y: newValue)
        }
    }
    
    var m_middleX : CGFloat {
        get {
            return m_width / 2
        }
    }
    
    var m_middleY : CGFloat {
        get {
            return m_height / 2
        }
    }
    
    var m_middlePoint : CGPoint {
        get {
           return CGPoint(x: m_middleX, y: m_middleY)
        }
    }

}

