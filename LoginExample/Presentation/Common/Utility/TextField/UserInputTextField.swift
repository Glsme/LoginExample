//
//  UserInputTextField.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import UIKit

class UserInputTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        clipsToBounds = true
        backgroundColor = .white
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
