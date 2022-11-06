//
//  SignupViewController.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import UIKit

import RxCocoa
import RxSwift

final class SignupViewController: BaseViewController {

    let mainView = SignView()
    let disposeBag = DisposeBag()
    let viewModel = SignupViewModel()
    
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
        let input = SignupViewModel.Input(nameText: mainView.userNameTextField.rx.text,
                                          emailText: mainView.emailTextField.rx.text,
                                          passwordText: mainView.passwordTextField.rx.text)
        let output = viewModel.transform(input: input)
        
        output.nameValidation
            .bind(to: mainView.emailTextField.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.emailValidation
            .bind(to: mainView.passwordTextField.rx.isHidden, mainView.signupButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.passwordValidation
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
                
                vc.viewModel.postSignup(userName: userName, email: email, password: password) {
                    DispatchQueue.main.async {
                        vc.dismiss(animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
