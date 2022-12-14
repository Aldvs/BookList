//
//  ViewController.swift
//  BookList
//
//  Created by admin on 13.09.2022.
//

import UIKit
import SnapKit
import KeychainSwift


class StartViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Public Properties
    let keychain = KeychainSwift(keyPrefix: "book_")

    //MARK: - Private Properties
    private let viewContainer = UIView()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let logInButton = UIButton(type: .custom)
    private let registerButton = UIButton(type: .custom)
    private let eyeButton = UIButton(type: .custom)
    
    //MARK: - View Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        setupElements()
        setupConstraints()
        setupEyeButton()
    }
    
    //MARK: Private Methods
    @objc private func logInPressed() {
        
        guard let inputUserText = loginTextField.text, !inputUserText.isEmpty else {
            showAlert(title: "Пустое поля логина", message: "Пожалуйста, введите свой логина")
            return
        }
        guard let inputPassText = passwordTextField.text, !inputPassText.isEmpty else {
            showAlert(title: "Пустое поле пароля", message: "Пожалуйста, введите пароль")
            return
        }

        let passCheck = SHAManager.shared.getHash(from: inputPassText)
        if passCheck == keychain.get(inputUserText) {
            self.keychain.set(true, forKey: "isAuth")
            let bookListVC = UINavigationController(rootViewController: MainViewController())
            bookListVC.modalPresentationStyle = .fullScreen
            present(bookListVC, animated: true)
        } else {
            showAlert(title: "Неверный логин или пароль", message: "Пожалуйста проверьте данные")
            passwordTextField.text = ""
        }
    }
    
    @objc private func registerPressed() {
        let registerVC = UINavigationController(rootViewController: RegisterViewController())
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true)
    }
    
    //MARK: - Setup EyeButton
    @objc private func btnPasswordVisibilityClicked(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        let senderValue = (sender as! UIButton).isSelected
        toggleEyeButton(senderValue)
    }

    private func setupEyeButton() {

        passwordTextField.rightViewMode = .unlessEditing

        let boldConfig = UIImage.SymbolConfiguration(weight: .light)
        let boldSearch = UIImage(systemName: "eye.slash", withConfiguration: boldConfig)

        eyeButton.setImage(boldSearch, for: .normal)
        eyeButton.tintColor = .black
        eyeButton.addTarget(self, action: #selector(self.btnPasswordVisibilityClicked(_:)), for: .touchUpInside)

        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true

    }

    private func toggleEyeButton(_ senderValue: Bool) {
        if senderValue {
            self.passwordTextField.isSecureTextEntry = false
            let boldConfig = UIImage.SymbolConfiguration(weight: .light)
            let boldSearch = UIImage(systemName: "eye", withConfiguration: boldConfig)
            eyeButton.setImage(boldSearch, for: .normal)
        } else {
            self.passwordTextField.isSecureTextEntry = true
            let boldConfig = UIImage.SymbolConfiguration(weight: .light)
            let boldSearch = UIImage(systemName: "eye.slash", withConfiguration: boldConfig)
            eyeButton.setImage(boldSearch, for: .normal)
        }
    }
}

//MARK: - Extensions
extension StartViewController {
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            logInPressed()
        }
        return true
    }

    private func setupElements() {

        viewContainer.backgroundColor = .lightGray
        viewContainer.layer.cornerRadius = 9
        viewContainer.layer.shadowRadius = 9
        viewContainer.layer.shadowOpacity = 0.3
        viewContainer.layer.shadowOffset = CGSize(width: 5, height: 8)
    
        loginTextField.delegate = self
        loginTextField.placeholder = "Логин"
        loginTextField.borderStyle = .roundedRect
        loginTextField.backgroundColor = UIColor.white
        loginTextField.keyboardType = .emailAddress
        loginTextField.returnKeyType = .next
        loginTextField.autocapitalizationType = .none
        
        passwordTextField.delegate = self
        passwordTextField.placeholder = "Пароль"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.returnKeyType = .next
        passwordTextField.autocapitalizationType = .none
        passwordTextField.returnKeyType = .done
        passwordTextField.isSecureTextEntry = true
        
        logInButton.setTitle("Войти", for: .normal)
        logInButton.layer.cornerRadius = 10
        logInButton.setTitleColor(UIColor.white, for: .normal)
        logInButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        logInButton.backgroundColor = UIColor.orange
        logInButton.titleLabel?.font = UIFont(name: "Futura", size: 20.0)
        
        logInButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
        
        registerButton.setTitle("Занести пользователя", for: .normal)
        registerButton.layer.cornerRadius = 10
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        registerButton.backgroundColor = UIColor.orange
        registerButton.titleLabel?.font = UIFont(name: "Futura", size: 20.0)
        
        registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }

    private func setupConstraints() {
        self.view.addSubview(viewContainer)
        viewContainer.addSubview(loginTextField)
        viewContainer.addSubview(passwordTextField)
        viewContainer.addSubview(logInButton)
        viewContainer.addSubview(registerButton)
        
        viewContainer.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.width.lessThanOrEqualTo(500)
            make.center.equalTo(self.view)
            make.height.equalTo(250)
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

        logInButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.left.equalTo(viewContainer).offset(30)
            make.right.equalTo(viewContainer).offset(-30)
            make.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(logInButton.snp.bottom).offset(16)
            make.left.equalTo(viewContainer).offset(30)
            make.right.equalTo(viewContainer).offset(-30)
            make.height.equalTo(50)
        }
    }

}


