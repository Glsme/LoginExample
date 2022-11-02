//
//  LoginViewController.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift

class LoginViewController: BaseViewController {
    
    let mainView = LoginView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bindData() {
        mainView.signupButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                let signupVC = SignupViewController()
                vc.present(signupVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        mainView.loginButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let email = vc.mainView.emailTextField.text else { return }
                guard let password = vc.mainView.passwordTextField.text else { return }
                
                APIService.shared.requestLogin(email: email, password: password) { result in
                    switch result {
                    case.success(_):
                        print("success")
                    case .failure(_):
                        print("failure")
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
