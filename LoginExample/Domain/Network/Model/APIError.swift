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

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return "데이터가 없습니다."
        case .errorInParsingData:
            return "데이터 파싱 과정 중 에러가 발생하였습니다."
        case .responseError:
            return "Reponse Error: 상태 코드를 체크해주세요"
        case .alreadyExist:
            return "이미 계정이 존재합니다."
        }
    }
}
