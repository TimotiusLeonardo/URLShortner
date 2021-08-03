//
//  ViewModel.swift
//  URLShortner
//
//  Created by Timotius Leonardo Lianoto on 03/08/21.
//

import Foundation


struct Model: Hashable {
    let long: String
    let short: String
}

class ViewModel: ObservableObject {
    
    @Published var models = [Model]()
    
    func submit(url: String) {
        guard URL(string: url) != nil else {
            return
        }
        
        // API Call
        
        guard let apiURL = URL(string: "https://api.1pt.co/addURL?long="+url.lowercased()) else {
            return
        }
        
        print(apiURL.absoluteString)
        
        let task = URLSession.shared.dataTask(with: apiURL) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            
            // Conver data to JSON
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                print("RESULT: \(result)")
                
                let long = result.long
                let short = result.short
                DispatchQueue.main.async {
                    self?.models.append(.init(long: long, short: short))
                }
                
            }
            catch {
                print(error)
            }
        }
        task.resume()
        
    }
}

struct APIResponse: Codable {
    let status: Int
    let message: String
    let short: String
    let long: String
}

// https://api.1pt.co/addURL?long=https://apple.com
/*
 {"status": 201, "message": "Added!", "short": "ymipq", "long": "https://apple.com"}
 */
