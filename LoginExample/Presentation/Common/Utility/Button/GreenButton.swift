//
//  GreenButton.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import UIKit

class GreenButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        layer.cornerRadius = 5
        clipsToBounds = true
        backgroundColor = .softGreen
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
