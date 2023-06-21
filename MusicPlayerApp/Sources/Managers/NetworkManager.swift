//
//  NetworkManager.swift
//  MusicPlayerApp
//
//  Created by Malik A. Aziz Lubis on 20/06/23.
//

import Foundation
import UIKit

class NetworkManager {
    
    class func fetchData(urlString: String, completion: @escaping ([Response]?, String?) -> Void) {
        //MARK: Header Parameter
        let headers = [
            "X-RapidAPI-Key": "bac0a5a2e7msh11f6e4607063586p10bd29jsnd1588cf5befe",
            "X-RapidAPI-Host": "spotify23.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from: data)
                    completion([response], nil)
                } catch {
                    completion(nil, "Gagal menguraikan JSON: \(error.localizedDescription)")
                    print("Gagal menguraikan JSON: \(error.localizedDescription)")
                }
            } else {
                completion(nil, "Error")
                print("error")
            }
        }
        task.resume()
    }
}
