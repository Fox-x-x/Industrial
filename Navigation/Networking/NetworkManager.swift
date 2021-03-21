//
//  NetworkManager.swift
//  Navigation
//
//  Created by Pavel Yurkov on 21.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

//Code=-1009 "The Internet connection appears to be offline."

struct NetworkManager {
    
    static let session = URLSession.shared
    
    static func dataTask(url: URL, completion: @escaping (String?) -> Void) {
        
        let _ = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                print("\n=============================")
                print("dataTask error:\n \(error.debugDescription)")
                print("\n=============================")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("\n=============================")
                print("HTTP response status code: \(httpResponse.statusCode)")
                print("=============================")
                print("HTTP response allheaderFields:\n \(httpResponse.allHeaderFields)")
                print("=============================")
            }
            
            if let data = data {
                completion( String(data: data, encoding: .utf8) )
            }
            
        }.resume()
    }
}
