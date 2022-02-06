//
//  NetworkManager.swift
//  News
//
//  Created by Sergey Yurtaev on 05.02.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from urlString: String, with complition: @escaping (News) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                complition(news)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
            
        }.resume()
    }
}

