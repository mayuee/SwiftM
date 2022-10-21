//
//  MPaintBrushSetViewController.swift
//  SwiftM
//
//  Created by mazb on 2022/10/22.
//

import UIKit

class MPaintBrushSetViewController: UIViewController {
    
    lazy var colorPreView : UIView = {
        let preView = UIView(frame: CGRect(x: 20, y: 80, width: view.m_width-40, height: 80))
        preView.backgroundColor = .white
        preView.layer.borderWidth = 2.0
        preView.layer.borderColor = UIColor.black.cgColor
        return preView
    }()
    
    var buttons : Array = Array<UIButton>()
    var buttonMore : UIButton?
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        loadSubViews()
        
        print("\(view.m_width)....\(view.m_height)")
    }
}

extension MPaintBrushSetViewController{
    private func loadSubViews(){
        view.addSubview(colorPreView)
        loadButtons()
    }
    
    private func loadButtons(){
        var index : Int = 0
        
        var frame = CGRect(x: colorPreView.m_left, y: colorPreView.m_bottom + 30, width: (colorPreView.m_width+5)/CGFloat(colors.count+1), height: 40)
        for color in colors{
            let button = UIButton(type: .system)
            button.frame = frame
            button.addTarget(self, action: #selector(colorSelected(button:)), for: .touchUpInside)
            button.backgroundColor = color
            button.tag = index
            view.addSubview(button)
            index = index + 1
            frame.origin.x = button.m_right + 5
            buttons.append(button)
        }
        
        let button = UIButton(type: .system)
        button.frame = frame
        button.addTarget(self, action: #selector(colorSelected(button:)), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitle("更多", for: .normal)
        button.tag = index
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        buttonMore = button
        buttons.append(buttonMore!)
        view.addSubview(buttonMore!)
        
    }
    
    @objc func colorSelected(button : UIButton){
        
        for temp in buttons{
            if button.tag != temp.tag  {
                temp.transform = CGAffineTransform.identity
            }
            else{
                temp.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                colorPreView.backgroundColor = button.backgroundColor
            }
        }
    }
}
