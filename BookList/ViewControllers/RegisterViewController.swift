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
    
    //MARK: - Public Properties
    let keychain = KeychainSwift(keyPrefix: "book_")
    
    //MARK: - Private Properties
    private let viewContainer = UIView()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let regNewPersonButton = UIButton(type: .custom)
    private let backButton = UIButton(type: .custom)
    private let eyeButton = UIButton(type: .custom)
    
    //MARK: - View LifeCycle Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        setupElements()
        setupConstraints()
        setupEyeButton()
    }

    
    //MARK: - Private Methods
    @objc private func regNewPersonButtonPressed() {
        
        guard let inputUserText = loginTextField.text, !inputUserText.isEmpty else {
            showAlert(title: "Пустое поля логина", message: "Пожалуйста, введите свой логина")
            return
        }
        guard let inputPassText = passwordTextField.text, !inputPassText.isEmpty else {
            showAlert(title: "Пустое поле пароля", message: "Пожалуйста, введите пароль")
            return
        }
        
        if keychain.set(SHAManager.shared.getHash(from: inputPassText), forKey: inputUserText) {
            showAlert(title: "Успешно!", message: "Пользователь зарегистрирован")
        } else {
            showAlert(title: "Ошибка!", message: "Что-то пошло не так")
        }
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true)
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
extension RegisterViewController {
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            regNewPersonButtonPressed()
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
        loginTextField.placeholder = "Новый логин"
        loginTextField.borderStyle = .roundedRect
        loginTextField.backgroundColor = UIColor.white
        loginTextField.keyboardType = .emailAddress
        loginTextField.returnKeyType = .next
        loginTextField.autocapitalizationType = .none
        
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
        
        backButton.setTitle("Вернуться", for: .normal)
        backButton.layer.cornerRadius = 10
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        backButton.backgroundColor = UIColor.orange
        backButton.titleLabel?.font = UIFont(name: "Futura", size: 20.0)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }

    private func setupConstraints() {
        self.view.addSubview(viewContainer)
        viewContainer.addSubview(loginTextField)
        viewContainer.addSubview(passwordTextField)
        viewContainer.addSubview(regNewPersonButton)
        viewContainer.addSubview(backButton)
        
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

        regNewPersonButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.left.equalTo(viewContainer).offset(30)
            make.right.equalTo(viewContainer).offset(-30)
            make.height.equalTo(50)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(regNewPersonButton.snp.bottom).offset(16)
            make.left.equalTo(viewContainer).offset(30)
            make.right.equalTo(viewContainer).offset(-30)
            make.height.equalTo(50)
        }
    }
}
