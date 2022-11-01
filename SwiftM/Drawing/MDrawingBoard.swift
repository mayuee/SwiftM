//
//  MDrawingBoard.swift
//  SwiftM
//
//  Created by mazb on 2022/10/19.
//

import UIKit
import QuartzCore

class MDrawingBoard: UIView {
    
    ///笔刷
    var paintBrush : MBrush = MBrush(color: .black, width: CGFloat(5.0), cat : .paint)
    
    ///当前 brush
    var curBrush : MBrush!

    ///橡皮
    lazy var eraserBrush : MBrush = MBrush(color:.white, width: CGFloat(10.0), cat : .eraser)
    
    ///画的 线 的数组
    lazy var lineArray : Array = Array<MBrushLine>()
    ///当前画的一条线
    var currentLine : MBrushLine? = nil

    weak var superController : UIViewController?

    
    ///用于判断当前画板是否为空
    var isEmpty : Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor

        curBrush = paintBrush
        eraserBrush.color = self.backgroundColor!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //获取上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //设置笔帽
        context.setLineCap(CGLineCap.round)
        //设置画线的连接处 拐点圆滑
        context.setLineJoin(.round)
        
        //划线之前,先把存放在线数组中的线画出来
        for mdLine in lineArray {
            guard var startPoint = mdLine.points.first else {
                continue
            }
            let color = mdLine.color.cgColor
            for movePoint in mdLine.points {
                context.beginPath()
                context.move(to: startPoint.point)
                context.setStrokeColor(color)
                context.addLine(to: movePoint.point)
                context.setLineWidth(movePoint.width)
//                if mdLine.cat == .eraser {
//                    context.setBlendMode(.copy)
//                }
                context.strokePath()
                startPoint = movePoint
            }
        }
        
        //画当前的线
        if currentLine != nil {
            let curLine = currentLine!
            guard var startPoint = curLine.points.first else {
                return
            }
            let color = curLine.color.cgColor
            for movePoint in curLine.points {
                context.beginPath()
                context.move(to: startPoint.point)
                context.setStrokeColor(color)
                context.addLine(to: movePoint.point)
                context.setLineWidth(movePoint.width)
//                if curLine.cat == .eraser {
//                    context.setBlendMode(.copy)
//                }
                context.strokePath()
                startPoint = movePoint
            }
        }
    }
}


// MARK: - MDrawingSetViewDelegate
extension MDrawingBoard : MDrawingSetViewDelegate{
    func pencilSelected() {
        curBrush = paintBrush
        
        if superController != nil {
            let paintSetVC = MPaintBrushSetViewController()
            paintSetVC.selectorColor = {(color : UIColor?)->Void in
                guard let setColor = color else{
                    self.superController?.dismiss(animated: true, completion: nil)
                    return
                }
                self.curBrush.color = setColor
                self.superController?.dismiss(animated: true, completion: nil)
            }

            superController?.present(paintSetVC, animated: true, completion: {
                
            })
            
//            XXXX.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    }
    
    func eraserSelected() {
        curBrush = eraserBrush
    }
    
    func revokeSelected() {
        if lineArray.count > 0 {
            lineArray.removeLast()
            setNeedsDisplay()
        }
    }
    
    func saveSelected() {
        let m = MHistoryModel()
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        MFileManager.shared.storageImage(image, withName: m.createDate)
        MDBClient.shared.insertHistory(model: m)
    }
    
    func clearSelected() {
        if lineArray.count > 0 {
            lineArray.removeAll()
            setNeedsDisplay()
        }
        self.curBrush = paintBrush
    }
}

// MARK: - touches
extension MDrawingBoard{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)

        currentLine = MBrushLine(color: curBrush.color, cat: curBrush.cat)
        if let touch = touches.first {
            let beginPoint = touch.location(in: self)
            let force = touch.force > 0 ? touch.force : 1
            let lineWidth = curBrush.width * force;
            currentLine!.addPoint(point: MBrushPoint(point: beginPoint, width: lineWidth))
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesMoved(touches, with: event)
        
        if let touch = touches.first {
            let movePoint = touch.location(in: self)
            let force = touch.force > 0 ? touch.force : 1
            let lineWidth = curBrush.width * force;
            currentLine!.addPoint(point: MBrushPoint(point: movePoint, width: lineWidth))
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super .touchesEnded(touches, with: event)
        
        if let touch = touches.first {
            let endPoint = touch.location(in: self)
            let force = touch.force > 0 ? touch.force : 1
            let lineWidth = curBrush.width * force;
            currentLine!.addPoint(point: MBrushPoint(point: endPoint, width: lineWidth))
        }
        if currentLine != nil {
            lineArray.append(currentLine!)
            currentLine = nil
        }
        setNeedsDisplay()
    }
}

extension MDrawingBoard{

}
