//
//  MBaseViewController.swift
//  SwiftM
//
//  Created by mazb on 2022/10/19.
//

import UIKit

class MBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 是否支持自转 看具体需求
    override var shouldAutorotate: Bool{
        return false
    }
    
    // 设置横屏方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeRight
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
