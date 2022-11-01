//
//  MPaintBrushSetViewController.swift
//  SwiftM
//
//  Created by mazb on 2022/10/22.
//

import UIKit

typealias SelectedColor = (UIColor?)->Void


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
    
    var selected : Bool = false
    
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
    
    var selectorColor : SelectedColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        loadSubViews()
        
        print("\(view.m_width)....\(view.m_height)")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        colorPreView.m_width = view.m_width - colorPreView.m_left*2
        var frame = CGRect(x: colorPreView.m_left, y: colorPreView.m_bottom + 30, width: (colorPreView.m_width+5)/CGFloat(buttons.count)-5, height: 40)
        for button in buttons {
            button.frame = frame
            frame.origin.x = button.m_right+5
        }
    }
}

extension MPaintBrushSetViewController{
    private func loadSubViews(){
        
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(commitAction), for: .touchUpInside)
        button.frame = CGRect(x: view.m_width-100, y: 30, width: 100, height: 30)
        button.backgroundColor = .white
        button.setTitle("确定", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 5.0
        view.addSubview(button)

        view.addSubview(colorPreView)
        loadButtons()
    }
    
    private func loadButtons(){
        var index : Int = 0
        
        for color in colors{
            let button = UIButton(type: .system)
            button.addTarget(self, action: #selector(colorSelected(button:)), for: .touchUpInside)
            button.backgroundColor = color
            button.tag = index
            view.addSubview(button)
            index = index + 1
            buttons.append(button)
        }
        
        let button = UIButton(type: .system)
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
        selected = true
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
    
    @objc func commitAction(){
        if selectorColor != nil {
            var color : UIColor? = nil
            if selected {
                color = colorPreView.backgroundColor!
            }
            selectorColor!(color)
        }
    }
}
