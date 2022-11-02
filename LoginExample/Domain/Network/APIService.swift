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
}

class APIService {
    static let shared = APIService()
    
    private init() { }
    
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
    
    func requestSignup() {
        let router = APIRouter.signup(userName: "hano", email: "hano@hano.com", password: "12345678")
        
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
            
            guard let data = data else { return }
            print(data)
            
            guard let response = response as? HTTPURLResponse else { return }
            print(response.statusCode)
            
            guard let parsingData = try? JSONDecoder().decode(Signup.self, from: data) else { return }
            
            print(parsingData)
            
            
            
        }.resume()
    }
}
