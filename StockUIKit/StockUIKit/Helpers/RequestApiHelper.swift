//
//  RequestApiHelper.swift
//  StockPOC
//
//  Created by Alvaro Torrez on 1/8/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

enum RequestMethods: String {
    case GET, POST, PUT
}

final class RequestApiHelper {
    
    static func getRequest<T>(urlString: String, parameters: [String:String]? = nil, headers: [String:String]? = nil, completion: @escaping (T) -> Void) where T: Codable {
        request(from: urlString, parameters: parameters, headers: headers) { result in
            print(result)
             switch result {
               case .success(let jsonString):
                   let decoder = JSONDecoder()
                   if let jsonSearchSYMResult = try? decoder.decode(T.self, from: jsonString.data(using: .utf8)!) {
                    completion(jsonSearchSYMResult)
                   }
               case .failure(let error):
                   //completion()
                   print(error)
               }
        }
    }
    
    static func request(from urlString: String, method: RequestMethods = .GET , parameters: [String:String]? = nil, headers: [String:String]? = nil, body: Data? = nil, completion: @escaping (Result<String, NetworkError>) -> Void) {
        var parametesOneString = [String]()
        if (parameters != nil && !parameters!.isEmpty) {
            parameters!.keys.forEach { (key) in
                parametesOneString.append("\(key)=\(parameters?[key] ?? "")")
            }
        }
        var fullUrl = urlString
        if !parametesOneString.isEmpty {
            fullUrl = fullUrl + "?" + parametesOneString.joined(separator: "&")
        }
        
        guard let url = URL(string: fullUrl) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}
