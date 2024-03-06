//
//  UIViewController_Ext.swift
//  GHFollowerClone
//
//  Created by DucLong on 26/02/2024.
//

import UIKit
fileprivate var containerView: UIView!

extension UIViewController {
    
    
    func presentGFAlertMainThread(title:String, message:String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle:title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle      = .overFullScreen
            alertVC.modalTransitionStyle        = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor           = .systemBackground
        containerView.alpha                     = 0
        
        UIView.animate(withDuration: 1) {
            containerView.alpha                 = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            if(containerView == nil) {return}
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyView(message:String, view: UIView){
        let containerView = GFEmptyView(message: message)
        containerView.frame = view.bounds
        view.addSubview(containerView)
    }
}
