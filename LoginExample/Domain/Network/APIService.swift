//
//  APIService.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import Foundation

enum APIError: Error {
    case noData
    case errorInParsingData
    case responseError
    case alreadyExist
}

class APIService {
    static let shared = APIService()
    
    private init() { }
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, parameters: [String: String], method: String , header: (String, String), completion: @escaping (Result<T, APIError>) -> Void) {
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
            guard let parsingData = String(data: data, encoding: .utf8) else { return completion(.failure(.alreadyExist)) }
//            completion(.success(data))
        }.resume()
    }
    
    func requestLogin(email: String, password: String, completionHandler: @escaping (Result<String, APIError>) -> Void) {
        let router = APIRouter.login(email: email, password: password)
        
        var component = URLComponents()
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in router.parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        component.queryItems = queryItems
        
        var request = URLRequest(url: router.url)
        
        request.httpMethod = router.httpMethod
        request.setValue(router.header.1, forHTTPHeaderField: router.header.0)
        request.httpBody = component.query?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let data = data else { return completionHandler(.failure(.noData)) }
            guard let parsingData = try? JSONDecoder().decode(Login.self, from: data) else { return completionHandler(.failure(.errorInParsingData)) }
            let token = parsingData.token
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return completionHandler(.failure(.responseError)) }
            
            print("Request Success: \(token)")
            
            completionHandler(.success("success"))
        }.resume()
    }
    
    func requestSignup(userName: String, email: String, password: String, completionHandler: @escaping (Result<String, APIError>) -> Void) {
        let router = APIRouter.signup(userName: userName, email: email, password: password)
        
        var component = URLComponents()
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in router.parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        component.queryItems = queryItems
        
        var request = URLRequest(url: router.url)
        
        request.httpMethod = router.httpMethod
        request.setValue(router.header.1, forHTTPHeaderField: router.header.0)
        request.httpBody = component.query?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("error: \(error!)")
                return
            }
            
            guard let data = data else { return completionHandler(.failure(.noData)) }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return completionHandler(.failure(.responseError)) }
            
            guard let parsingData = String(data: data, encoding: .utf8) else { return completionHandler(.failure(.alreadyExist)) }
            completionHandler(.success(parsingData))
            
        }.resume()
    }
}
