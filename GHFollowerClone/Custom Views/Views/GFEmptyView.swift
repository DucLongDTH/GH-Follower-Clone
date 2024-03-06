//
//  GFEmptyView.swift
//  GHFollowerClone
//
//  Created by DucLong on 06/03/2024.
//

import UIKit

class GFEmptyView: UIView {
    
    let imageView               = UIImageView()
    let messageLabel            = GFBodyLabel(textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    private func configure(){
        addSubview(imageView)
        addSubview(messageLabel)
        messageLabel.numberOfLines      = 3
        messageLabel.textColor          = .secondaryLabel
        
        imageView.image                 = UIImage(named: "empty-state-logo")
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -80),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 80),
        ])
        
    }
}
