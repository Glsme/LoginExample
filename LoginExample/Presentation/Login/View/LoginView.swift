//
//  LoginView.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import UIKit

import SnapKit

class LoginView: BaseView {
    let emailTextField: UserInputTextField = {
        let view = UserInputTextField()
        view.placeholder = "이메일을 입력해주세요"
        return view
    }()
    
    let passwordTextField: UserInputTextField = {
        let view = UserInputTextField()
        view.placeholder = "비밀번호를 입력해주세요"
        return view
    }()
    
    let loginButton: GreenButton = {
        let view = GreenButton()
        view.setTitle("로그인", for: .normal)
        return view
    }()
    
    let signupButton: GreenButton = {
        let view = GreenButton()
        view.setTitle("회원가입", for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [emailTextField, passwordTextField, loginButton, signupButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalTo(passwordTextField.snp.top).offset(-50)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).multipliedBy(0.8)
            make.height.equalTo(emailTextField.snp.height)
            make.width.equalTo(emailTextField.snp.width)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(emailTextField.snp.height)
            make.width.equalTo(emailTextField.snp.width)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(emailTextField.snp.height)
            make.width.equalTo(emailTextField.snp.width)
        }
    }
}
