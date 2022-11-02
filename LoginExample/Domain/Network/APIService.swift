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
    
    func requestLogin() {
        var url = URL(string: "http://api.memolease.com/api/v1/users/login")!
        
        let email = "hano@hano.com".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let userInfo: [URLQueryItem] = [
            URLQueryItem(name: "email", value: email),
            URLQueryItem(name: "password", value: "12345678")
        ]
        
        var component = URLComponents()
        component.queryItems = [
            URLQueryItem(name: "email", value: email),
            URLQueryItem(name: "password", value: "12345678"),
            URLQueryItem(name: "Content-Type", value: "application/x-www-form-urlencoded")
        ]
        
        url.append(queryItems: userInfo)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = component.query?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("error: \(error!)")
                return
            }
            
            guard let data = data else { return }
            guard let parsingData = try? JSONDecoder().decode(Login.self, from: data) else { return }
            let token = parsingData.token
            
            let outputStr = String(data: data, encoding: String.Encoding.utf8)
            print("result: \(outputStr!)")
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
        }.resume()
    }
}
