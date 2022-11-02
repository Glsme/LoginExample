//
//  BaseView.swift
//  LoginExample
//
//  Created by Seokjune Hong on 2022/11/02.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() { }
    
    func setConstraints() { }
}
