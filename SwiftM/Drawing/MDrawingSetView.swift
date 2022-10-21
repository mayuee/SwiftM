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
    
    var segment : UISegmentedControl?
    
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
        var top : CGFloat = 84
        let w : CGFloat = self.m_width - 10.0
        let h : CGFloat = (self.m_height-84-40) / 5.0
        let penButton = UIButton(type: .custom)
        penButton.frame = CGRect(x: left, y: top, width: w, height: h)
        penButton.setImage(UIImage(named: "pen"), for: .normal)
        penButton.addTarget(self, action: #selector(penClick), for: .touchUpInside)
        self.addSubview(penButton)
        
        
        top = penButton.m_bottom + 10;
        let eraserButton = UIButton(type: .custom)
        eraserButton.frame = CGRect(x: left, y: top, width: w, height: h)
        eraserButton.setImage(UIImage(named: "eraser"), for: .normal)
        eraserButton.addTarget(self, action: #selector(eraserClick), for: .touchUpInside)
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
    @objc func penClick(){
        self.delegate?.pencilSelected()
    }
    
    //橡皮
    @objc func eraserClick(){
        self.delegate?.eraserSelected()
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

