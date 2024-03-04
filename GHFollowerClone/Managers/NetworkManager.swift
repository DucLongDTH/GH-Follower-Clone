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
    
    func getFollowers(page:Int, completed: @escaping (Result<[Follower], GFError>) -> Void)  {
        var endpoint = ""
        if(page > 0){
             endpoint = baseUrl + "follower"
        } else {
             endpoint = baseUrl + "follower"
        }
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(GFError.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let _ = error {
                completed(.failure(GFError.noInternetConnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
        
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
                
            } catch {
                completed(.failure(.invalidData))
                return
            }
            
        }
        task.resume()
    }
}
