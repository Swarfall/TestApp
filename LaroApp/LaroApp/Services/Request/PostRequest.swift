//
//  PostRequest.swift
//  LaroApp
//
//  Created by Viacheslav Savitskyi on 17.07.2021.
//

import Foundation

final class PostRequests {
    
    private var networkClient = NetworkClient()
    
    func getPosts(limit: Int, completion: (([GiphyData]) -> Void)?, failure: ((Error?) -> Void)?) {
        
        networkClient.request(path: RequestPath.baseURL.rawValue,
                              method: .get,
                              urlParams: "?api_key=\(RequestPath.apiKey.rawValue)&limit=\(limit)") { data in
            do {
                let giphy = try JSONDecoder().decode(Giphy.self, from: data)
                completion?(giphy.data)
            } catch let error {
                failure?(error)
            }
        } failure: { error in
            failure?(error)
        }
    }
}
