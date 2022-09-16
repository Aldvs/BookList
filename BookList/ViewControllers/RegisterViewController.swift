//
//  RegisterViewController.swift
//  BookList
//
//  Created by admin on 16.09.2022.
//

import UIKit
import SnapKit
import KeychainSwift

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    let viewContainer = UIView()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let regNewPersonButton = UIButton(type: .custom)
    
    let keychain = KeychainSwift(keyPrefix: "book_")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupElements()
        setupConstraints()
    }
    
    private func setupElements() {
        viewContainer.backgroundColor = .yellow
        viewContainer.layer.cornerRadius = 9
        viewContainer.layer.shadowRadius = 9
        viewContainer.layer.shadowOpacity = 0.3
        viewContainer.layer.shadowOffset = CGSize(width: 5, height: 8)
        
        
        // Set self as the delegate of the textfield so we can handle the Return button.
        loginTextField.delegate = self
        loginTextField.placeholder = "Новый логин"
        loginTextField.borderStyle = .roundedRect
        loginTextField.backgroundColor = UIColor.white
        loginTextField.keyboardType = .emailAddress
        loginTextField.returnKeyType = .next
        loginTextField.autocapitalizationType = .none
        
        // Set self as the delegate of the textfield so we can handle the Return button.
        passwordTextField.delegate = self
        passwordTextField.placeholder = "Новый пароль"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.returnKeyType = .next
        passwordTextField.autocapitalizationType = .none
        passwordTextField.returnKeyType = .done
        passwordTextField.isSecureTextEntry = true
        
        regNewPersonButton.setTitle("Занести", for: .normal)
        regNewPersonButton.layer.cornerRadius = 10
        regNewPersonButton.setTitleColor(UIColor.white, for: .normal)
        regNewPersonButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        regNewPersonButton.backgroundColor = UIColor.orange
        regNewPersonButton.titleLabel?.font = UIFont(name: "Futura", size: 20.0)
        
        regNewPersonButton.addTarget(self, action: #selector(regNewPersonButtonPressed), for: .touchUpInside)
        
        
    }

    private func setupConstraints() {
        self.view.addSubview(viewContainer)
        viewContainer.addSubview(loginTextField)
        viewContainer.addSubview(passwordTextField)
        viewContainer.addSubview(regNewPersonButton)
        
        viewContainer.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.width.lessThanOrEqualTo(500)
            make.center.equalTo(self.view)
            make.height.equalTo(192)
        }
        
        loginTextField.snp.makeConstraints { (make) in
            make.top.equalTo(viewContainer.snp.topMargin).offset(20)
            make.left.equalTo(viewContainer).offset(10)
            make.right.equalTo(viewContainer).offset(-10)
            make.height.equalTo(30)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(loginTextField.snp.bottom).offset(20)
            make.left.equalTo(viewContainer).offset(10)
            make.right.equalTo(viewContainer).offset(-10)
            make.height.equalTo(30)
        }

        regNewPersonButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.left.equalTo(viewContainer).offset(30)
            make.right.equalTo(viewContainer).offset(-30)
            make.height.equalTo(50)
        }
    
    }
    
    @objc private func regNewPersonButtonPressed() throws {
        
        dismiss(animated: true)
    }
}