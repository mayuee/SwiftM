//
//  MDrawingColorView.swift
//  SwiftM
//
//  Created by mazb on 2022/10/21.
//

import UIKit

typealias selectedColor = (UIColor?)->Void


class MDrawingColorView: UIView {
    
    var selectIndex : NSInteger = 0 {
        didSet{
            for index in 0..<buttons.count{
                let button = buttons[index]
                if index != selectIndex {
                    button.transform = transform.scaledBy(x: 1.0, y: 1.0)
                }
                else{
                    button.transform = transform.scaledBy(x: 1.2, y: 1.2)
                }
            }
        }
    }
    
    
    var buttons : Array = Array<UIButton>()
    
    let colors : Array<UIColor> = [
        .black,
        .red,
        .green,
        .orange,
        .yellow,
        .cyan,
        .blue,
        .purple,
        .gray,
        .brown,
        .magenta,
        .systemPink
    ]
    
    var buttonMore : UIButton?
    
    var setColor : selectedColor?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        loadSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func loadSubView(){
        var index : Int = 0
        var frame = CGRect(x: 0, y: 0, width: self.m_width, height: (self.m_height / (CGFloat(colors.count)+1.0) - 5))
        for color in colors{
            let button = UIButton(type: .system)
            button.frame = frame
            button.addTarget(self, action: #selector(colorSelected(button:)), for: .touchUpInside)
            button.backgroundColor = color
            button.tag = index
            self.addSubview(button)
            index = index + 1
            frame.origin.y = button.m_bottom
        }
        
        let button = UIButton(type: .system)
        button.frame = frame
        button.addTarget(self, action: #selector(colorSelected(button:)), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitle("更多", for: .normal)
        button.tag = index
        button.layer.cornerRadius = 10
        buttonMore = button
        self.addSubview(buttonMore!)
    }
    
    @objc func colorSelected(button : UIButton){
        if setColor == nil {
            return
        }
        if button.tag < colors.count {
            let color = colors[button.tag]
            setColor!(color)
        }
        else{
            setColor!(nil)
        }
    }

}
