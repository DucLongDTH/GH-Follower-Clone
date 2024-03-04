//
//  FollowersListVC.swift
//  GHFollowerClone
//
//  Created by DucLong on 25/02/2024.
//

import UIKit

class FollowersListVC: UIViewController {
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(page: 0) { (followers, errorMess) in
            guard let followers = followers else {
                self.presentGFAlertMainThread(title: "Error Call API", message: errorMess!.rawValue, buttonTitle: "OK")
                return
            }
            print("Followers.count = \(followers.count)")
            print("Followers.detail: \(followers)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
