//
//  SignupViewModel.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import Foundation

class SignupViewModel {
    final func postSignup(userName: String, email: String, password: String, completion: @escaping () -> Void) {
        let router = APIRouter.signup(userName: userName, email: email, password: password)
        APIService.shared.requestSeSAC(type: String.self, url: router.url, parameters: router.parameters, method: router.httpMethod, header: router.header) { response in
            switch response {
            case .success(let success):
                print(success)
                completion()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
