//
//  Follower.swift
//  GHFollowerClone
//
//  Created by DucLong on 28/02/2024.
//

import Foundation

struct Follower : Codable, Hashable {
    var name: String
    var imageUrl: String
    var followerNumber: Int
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(name)
    }
}
