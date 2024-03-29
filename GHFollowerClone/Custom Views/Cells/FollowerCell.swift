//
//  FollowerCell.swift
//  GHFollowerClone
//
//  Created by DucLong on 04/03/2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    let avtImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower:Follower){
        usernameLabel.text = follower.name
        avtImageView.downloadImage(urlString: follower.imageUrl)
    }
    
    private func configure() {
        addSubview(avtImageView)
        addSubview(usernameLabel)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avtImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avtImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avtImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avtImageView.heightAnchor.constraint(equalTo: avtImageView.widthAnchor),
                        
            usernameLabel.topAnchor.constraint(equalTo: avtImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}
