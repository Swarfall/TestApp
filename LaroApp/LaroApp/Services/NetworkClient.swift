//
//  NetworkClient.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 16.07.2021.
//

import Foundation

final class NetworkClient {
    func request(path: String, method: HTTPMethod = .get, urlParams: String? = nil, completion: @escaping (Data) -> Void, failure: @escaping (Error?) -> Void) {
        
        var newPath = path
        
        if let urlParams = urlParams {
            newPath.append(urlParams)
        }
        
        guard let url = URL(string: newPath) else {
            failure(GiphyError.tryAgain)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, responce, error) in
            guard let data = data else { return }
            
            if error == nil {
                completion(data)
            } else {
                guard let error = error else { return }
                failure(error)
            }
        }.resume()
    }
}
