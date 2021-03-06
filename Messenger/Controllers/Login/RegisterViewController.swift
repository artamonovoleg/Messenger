//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Олег Артамонов on 05.04.2021.
//

import UIKit

class RegisterViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView();
        scrollView.clipsToBounds = true;
        return scrollView;
    }();
    
    private let emailField: UITextField = {
        let field = UITextField();
        field.autocapitalizationType = .none;
        field.autocorrectionType = .no;
        field.returnKeyType = .continue;
        field.layer.cornerRadius = 12;
        field.layer.borderWidth = 1;
        field.layer.borderColor = UIColor.lightGray.cgColor;
        field.placeholder = "Email Address...";
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0));
        field.leftViewMode = .always;
        field.backgroundColor = .white;
        
        return field;
    }();
    
    
    private let passwordField: UITextField = {
        let field = UITextField();
        field.autocapitalizationType = .none;
        field.autocorrectionType = .no;
        field.returnKeyType = .done;
        field.layer.cornerRadius = 12;
        field.layer.borderWidth = 1;
        field.layer.borderColor = UIColor.lightGray.cgColor;
        field.placeholder = "Password...";
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0));
        field.leftViewMode = .always;
        field.backgroundColor = .white;
        field.isSecureTextEntry = true;
        
        return field;
    }();
    
    private let registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal);
        button.backgroundColor      = .link;
        button.setTitleColor(.white, for: .normal);
        button.layer.cornerRadius   = 12;
        button.layer.masksToBounds  = true;
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold);
        
        return button;
    }();
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Register";
        view.backgroundColor = .white;
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                                                        title: "Register",
                                                        style: .done,
                                                        target: self,
                                                        action: #selector(DidTapRegister))
        
        registerButton.addTarget(self,
                              action: #selector(DidTapLogin),
                              for: .touchUpInside)
        
        emailField.delegate = self;
        passwordField.delegate = self;
        
        view.addSubview(scrollView);
        scrollView.addSubview(emailField);
        scrollView.addSubview(passwordField);
        scrollView.addSubview(registerButton);
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews();
        scrollView.frame = view.bounds;
        
        emailField.frame = CGRect(x: 30,
                                  y: 20,
                                  width: scrollView.width - 60,
                                  height: 52);
        
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52);
        
        registerButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 52);
    }
    
    @objc private func DidTapLogin()
    {
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty else {
            alertUserLoginError();
            return
        }
    }
    
    func alertUserLoginError()
    {
        let alert = UIAlertController(
            title: "Ooops...",
            message: "Please enter all",
            preferredStyle: .alert);
        
        alert.addAction(UIAlertAction(
                            title:"Dismiss",
                            style: .cancel,
                            handler: nil));
        
        present(alert, animated: true);
    }
    
    @objc private func DidTapRegister()
    {
        let vc = RegisterViewController();
        vc.title = "Create Account";
        navigationController?.pushViewController(vc, animated: true);
    }
}


extension RegisterViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == emailField
        {
            passwordField.becomeFirstResponder();
        }
        else
        if textField == passwordField
        {
            DidTapLogin();
        }
        return true;
    }
}
