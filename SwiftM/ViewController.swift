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
        
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()
        
        setupSubViews()
    }
}


// MARK: - 正常
extension ViewController{
    private func setupNav() {
        self.title = "念念画画";
        
        let nextItem = UIBarButtonItem(title:"历史", style: .plain, target: self, action: #selector(historyAction))
        self.navigationItem.rightBarButtonItem = nextItem;
    }
    
    func setupSubViews(){
        drawingBoard.frame = view.bounds
        view.addSubview(drawingBoard)
        
        setView = MDrawingSetView(frame: CGRect(x: view.m_width-60, y: 0, width: 60, height: view.m_height))
        setView?.delegate = drawingBoard
        view.addSubview(setView!)
    }
    
    @objc func historyAction() {
        let history = MHistoryViewController()
        self.navigationController?.pushViewController(history, animated: true)
    }
}






// MARK: - 访客
extension ViewController{
    func setupVisitorView() {
        
    }
}
