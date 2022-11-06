//
//  APIService.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    private init() { }
    
    final func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, parameters: [String: String], method: String , header: (String, String), completion: @escaping (Result<T, APIError>) -> Void) {
        var component = URLComponents()
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        component.queryItems = queryItems
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.setValue(header.1, forHTTPHeaderField: header.0)
        request.httpBody = component.query?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("error: \(error!)")
                return
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return completion(.failure(.responseError)) }
            guard let parsingData = try? JSONDecoder().decode(T.self, from: data) else { return completion(.failure(.errorInParsingData)) }
            completion(.success(parsingData))
        }.resume()
    }
}
