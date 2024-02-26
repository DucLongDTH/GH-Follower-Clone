//
//  UIViewController_Ext.swift
//  GHFollowerClone
//
//  Created by DucLong on 26/02/2024.
//

import UIKit

extension UIViewController {
    
    func presentGFAlertMainThread(title:String, message:String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle:title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle      = .overFullScreen
            alertVC.modalTransitionStyle        = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
