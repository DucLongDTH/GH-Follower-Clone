//
//  NetworkManager.swift
//  GHFollowerClone
//
//  Created by DucLong on 28/02/2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://65df277bff5e305f32a19484.mockapi.io/api/test/"
    
    private init() {}
    
    func getFollowers(page:Int, completed: @escaping ([Follower]?, String?) -> Void)  {
        var endpoint = ""
        if(page > 0){
             endpoint = baseUrl + "follower"
        } else {
             endpoint = baseUrl + "follower"
        }
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "Error, try again!")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let _ = error {
                completed(nil, "Cant connect to server, check internet again")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil,"Invalid response from Server")
                return
            }
        
            guard let data = data else {
                completed(nil,"Data received error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
                
            } catch {
                completed(nil,"Data received error")
                return
            }
            
        }
        task.resume()
        
        
    }
}