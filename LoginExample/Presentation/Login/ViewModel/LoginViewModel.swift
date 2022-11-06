//
//  LoginViewModel.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import Foundation

class LoginViewModel {
    public func requsetLogin(email: String, password: String, completion: @escaping () -> Void) {
        let api = APIRouter.login(email: email, password: email)
        
        APIService.shared.requestSeSAC(type: Login.self, url: api.url, parameters: api.parameters, method: api.httpMethod, header: api.header) { response in
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
