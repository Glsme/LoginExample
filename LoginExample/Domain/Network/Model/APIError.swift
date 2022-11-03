//
//  APIError.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/04.
//

import Foundation

enum APIError: Error {
    case noData
    case errorInParsingData
    case responseError
    case alreadyExist
}
