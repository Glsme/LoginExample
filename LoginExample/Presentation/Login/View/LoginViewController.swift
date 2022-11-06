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
    let viewModel = LoginViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bindData() {
        
        mainView.emailTextField.rx.controlEvent(.editingDidBegin)
            .asObservable()
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.mainView.emailTextField.layer.borderColor = UIColor.black.cgColor
            }
            .disposed(by: disposeBag)
        
        mainView.emailTextField.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.mainView.emailTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.controlEvent(.editingDidBegin)
            .asObservable()
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.mainView.passwordTextField.layer.borderColor = UIColor.black.cgColor
            }
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .withUnretained(self)
            .subscribe { (vc, _) in
                vc.mainView.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
            .disposed(by: disposeBag)
        
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
                
                vc.viewModel.requsetLogin(email: email, password: password) {
                    print("Success")
                }
            }
            .disposed(by: disposeBag)
    }
}
