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
            .bind { _ in
                APIService.shared.requestLogin()
            }
            .disposed(by: disposeBag)
    }
}
