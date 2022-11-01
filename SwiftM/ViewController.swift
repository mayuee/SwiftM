//
//  ViewController.swift
//  SwiftM
//
//  Created by mazb on 2022/10/19.
//

import UIKit


class ViewController: UIViewController {

    var isLogin : Bool = true
    
    let drawingBoard : MDrawingBoard = MDrawingBoard()
    
    var setView : MDrawingSetView?
    
    /*
    lazy var colorView : MDrawingColorView = {
        let cv = MDrawingColorView()
        cv.setColor = {(color : UIColor?)->Void in
            guard let setColor = color else{
                return
            }
        }
        
        return cv
    }()
 */
        
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.edgesForExtendedLayout = []
        
        setupNav()
        
        setupSubViews()
    }
}


// MARK: - 正常
extension ViewController{
    private func setupNav() {
        self.title = "画画";
        
        let nextItem = UIBarButtonItem(title:"历史", style: .plain, target: self, action: #selector(historyAction))
        self.navigationItem.rightBarButtonItem = nextItem;
    }
    
    func setupSubViews(){
        
        var safeInset = UIEdgeInsets()
        if #available(iOS 11.0, *) {
            if let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets{
                safeInset = safeAreaInsets
            }
        }
        
        drawingBoard.frame = CGRect(x: safeInset.left, y: safeInset.top+44, width: view.m_width-safeInset.left-safeInset.right-60, height: view.m_height-safeInset.top-44-safeInset.bottom)
        drawingBoard.superController = self
        view.addSubview(drawingBoard)
        
        setView = MDrawingSetView(frame: CGRect(x: view.m_width-safeInset.right-60, y: drawingBoard.m_top, width: 60, height: drawingBoard.m_height))
        setView?.delegate = drawingBoard
        view.addSubview(setView!)
    }
    
    @objc func historyAction() {
        let drawed = MDrawedViewController()
        self.navigationController?.pushViewController(drawed, animated: true)
    }
}


// MARK: - 画笔设置回调
extension ViewController{
    
}




// MARK: - 访客
extension ViewController{
    func setupVisitorView() {
        
    }
}
