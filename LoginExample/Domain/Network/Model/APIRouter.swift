//
//  APIRouter.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import Foundation

enum APIRouter {
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
}

extension APIRouter {
    var url: URL {
        switch self {
        case .signup:
            return URL(string: "http://api.memolease.com/api/v1/users/signup")!
        case .login:
            return URL(string: "http://api.memolease.com/api/v1/users/login")!
        case .profile:
            return URL(string: "http://api.memolease.com/api/v1/users/me")!
        }
    }
    
    var header: (String, String) {
        switch self {
        case .signup, .login:
            return ("Content-Type", "application/x-www-form-urlencoded")
        case .profile:
            return ("test", "test")
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .signup(let userName, let email, let password):
            return [
                "userName": userName,
                "email": email,
                "password": password
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default: return ["":""]
        }
    }
    
    var httpMethod: String {
        switch self {
        case .signup, .login:
            return "POST"
        case .profile:
            return "GET"
        }
    }
}
