//
//  SignupViewModel.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import Foundation

import RxCocoa
import RxSwift

final class SignupViewModel {
    
    
    struct Input {
        let nameText: ControlProperty<String?>
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
    }
    
    struct Output {
        let nameValidation: Observable<Bool>
        let emailValidation: Observable<Bool>
        let passwordValidation: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let nameValidation = input.nameText
            .orEmpty
            .map { $0.count < 2 }
        
        let emailValidation = input.emailText
            .orEmpty
            .map { $0.count < 5 }
        
        let passwordValidation = input.passwordText
            .orEmpty
            .map { $0.count >= 8 }
        
        return Output(nameValidation: nameValidation, emailValidation: emailValidation, passwordValidation: passwordValidation)
    }
    
    public func postSignup(userName: String, email: String, password: String, completion: @escaping () -> Void) {
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
