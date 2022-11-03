//
//  SignupViewController.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift

class SignupViewController: BaseViewController {

    let mainView = SignView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureUI() {
        mainView.emailTextField.isHidden = true
        mainView.passwordTextField.isHidden = true
        mainView.signupButton.isHidden = true
        mainView.signupButton.isEnabled = false
        mainView.signupButton.backgroundColor = .lightGray
    }
    
    override func bindData() {
        mainView.userNameTextField.rx.text
            .orEmpty
            .map { $0.count < 2 }
            .bind(to: mainView.emailTextField.rx.isHidden)
            .disposed(by: disposeBag)
        
        mainView.emailTextField.rx.text
            .orEmpty
            .map { $0.count < 5 }
            .bind(to: mainView.passwordTextField.rx.isHidden, mainView.signupButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.text
            .orEmpty
            .map { $0.count > 8 }
            .withUnretained(self)
            .bind(onNext: { (vc, value) in
                if value {
                    vc.mainView.signupButton.backgroundColor = .softGreen
                    vc.mainView.signupButton.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
        
        mainView.signupButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let userName = vc.mainView.userNameTextField.text else { return }
                guard let email = vc.mainView.emailTextField.text else { return }
                guard let password = vc.mainView.passwordTextField.text else { return }
                
                APIService.shared.requestSignup(userName: userName, email: email, password: password) { result in
                    switch result {
                    case .success(let value):
                        print("success: \(value)")
                    case .failure(let error):
                        print("error \(error)")
                    }
                }
//                vc.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
