//
//  MDrawingSetView.swift
//  SwiftM
//
//  Created by mazb on 2022/10/20.
//

import UIKit

@objc protocol MDrawingSetViewDelegate {
    //选择画笔
    func pencilSelected() -> Void
    
    //选择橡皮
    func eraserSelected() -> Void

    //撤销一步
    func revokeSelected() -> Void

    //保存
    func saveSelected() -> Void
    
    //清空
    func clearSelected() -> Void
}


class MDrawingSetView: UIView {

    weak var delegate : MDrawingSetViewDelegate?
    
    //记录当前选中的是画笔还是橡皮
    var button_pen_eraser : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        loadSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension MDrawingSetView{
    func loadSubView(){

        let left : CGFloat = 5.0
        var top : CGFloat = 10
        let w : CGFloat = self.m_width - 10.0
        let h : CGFloat = (self.m_height-60) / 5.0
        let penButton = UIButton(type: .custom)
        penButton.frame = CGRect(x: left, y: top, width: w, height: h)
        penButton.setImage(UIImage(named: "pen"), for: .normal)
        penButton.addTarget(self, action: #selector(penClick(button:)), for: .touchUpInside)
        button_pen_eraser = penButton
        penButton.backgroundColor = .yellow
        self.addSubview(penButton)
        
        
        top = penButton.m_bottom + 10;
        let eraserButton = UIButton(type: .custom)
        eraserButton.frame = CGRect(x: left, y: top, width: w, height: h)
        eraserButton.setImage(UIImage(named: "eraser"), for: .normal)
        eraserButton.addTarget(self, action: #selector(eraserClick(button:)), for: .touchUpInside)
        self.addSubview(eraserButton)
        
        top = eraserButton.m_bottom + 10;
        let revokeButton = UIButton(type: .custom)
        revokeButton.frame = CGRect(x: left, y: top, width: w, height: h)
        revokeButton.setImage(UIImage(named: "revoke"), for: .normal)
        revokeButton.addTarget(self, action: #selector(revokeClick), for: .touchUpInside)
        self.addSubview(revokeButton)

        
        top = revokeButton.m_bottom + 10;
        let saveButton = UIButton(type: .custom)
        saveButton.frame = CGRect(x: left, y: top, width: w, height: h)
        saveButton.setImage(UIImage(named: "save"), for: .normal)
        saveButton.addTarget(self, action: #selector(saveClick), for: .touchUpInside)
        self.addSubview(saveButton)
        
        top = saveButton.m_bottom + 10;
        let clearButton = UIButton(type: .custom)
        clearButton.frame = CGRect(x: left, y: top, width: w, height: h)
        clearButton.setImage(UIImage(named: "revoke"), for: .normal)
        clearButton.addTarget(self, action: #selector(clearClick), for: .touchUpInside)
        self.addSubview(clearButton)
    }
    
    //选择画笔
    @objc func penClick(button : UIButton!){
        self.delegate?.pencilSelected()
        if button_pen_eraser != button {
            button_pen_eraser?.backgroundColor = .clear
            button_pen_eraser = button
            button_pen_eraser?.backgroundColor = .yellow
        }
    }
    
    //橡皮
    @objc func eraserClick(button : UIButton!){
        self.delegate?.eraserSelected()
        if button_pen_eraser != button {
            button_pen_eraser?.backgroundColor = .clear
            button_pen_eraser = button
            button_pen_eraser?.backgroundColor = .yellow
        }

    }
    
    //撤销
    @objc func revokeClick(){
        self.delegate?.revokeSelected()
    }
    
    //保存
    @objc func saveClick(){
        self.delegate?.saveSelected()
    }
    
    @objc func clearClick(){
        self.delegate?.clearSelected()
    }

}

