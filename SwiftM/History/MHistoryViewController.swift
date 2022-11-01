//
//  MHistoryViewController.swift
//  SwiftM
//
//  Created by mazb on 2022/10/19.
//

import UIKit

class MHistoryViewController: MBaseViewController {

    lazy var tableView : UITableView = UITableView()
    var dataArray : Array = Array<MHistoryModel>()
    
    
    var isPresent : Bool = true
    
//    lazy var tableView : UITableView = {
//        let temp = UITableView()
//        temp.dataSource = self
//        temp.delegate = self
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let array = MDBClient.shared.getHistoryList(){
            for ele in array {
                dataArray.append(ele)
            }
        }
       
        setupUI()
    }
}

extension MHistoryViewController{
    
    func setupUI() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension MHistoryViewController : UITableViewDelegate, UITableViewDataSource{
    // MARK: -- TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = "测试数据: \(indexPath.row)"
        
        return cell!
    }
}

extension MHistoryViewController : UIViewControllerTransitioningDelegate{
    func popupController(){
        let vc = UIViewController()
        vc.modalPresentationStyle = .custom // 遮挡的前视图不会清理
        vc.transitioningDelegate = self
        self .present(vc, animated: true, completion: nil)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let present = MPresentationController(presentedViewController: presented, presenting: presenting)
        present.presentFrame = CGRect()
        return present
        //return UIPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    ///自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
    ///自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
}

extension MHistoryViewController : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    /// 获取 转场上下文，通过上下文获取 弹出的 view 和 消失的 view
    // UITransitionContextViewKey  Currently only two keys are defined by the system:
    //   UITransitionContextToViewKey
    //   UITransitionContextFromViewKey

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPresent ? presentAnimation(using: transitionContext) : dissmissAnimation(using: transitionContext)
        
    }
    
    private func presentAnimation(using transitionContext: UIViewControllerContextTransitioning){
        let presentView = transitionContext.view(forKey: .to)
        
        //将弹出的视图添加
        transitionContext.containerView.addSubview(presentView!)
        
        presentView?.transform = CGAffineTransform(scaleX: 1.0, y: 0)
        presentView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            presentView?.transform = CGAffineTransform.identity
        } completion: { (_) in
            //必须告诉上下文已经完成动画
            transitionContext.completeTransition(true)
        }
    }
    
    private func dissmissAnimation(using transitionContext: UIViewControllerContextTransitioning){
        
    }
}
