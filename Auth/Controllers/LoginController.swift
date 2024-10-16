//
//  LoginController.swift
//  BillionerProject
//
//  Created by Aslanli Faqan on 05.10.24.
//

import UIKit
final class LoginController: UIViewController {
    
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var mailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
//        UserDefaultsHelper.setInteger(key: "LoginType", value: 1)
//        UserDefaultsHelper.setInteger(key: UserDefaultsKey.loginType.rawValue, value: 1)
    }
    fileprivate func configureUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        configureButton()
        configureTextField()
    }
    
    fileprivate func configureButton() {
        signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        signInButton.setTitle("Login", for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        signUpButton.setTitle("Sign Up", for: .normal)
    }
    
    @objc
    fileprivate func signUpButtonClicked() {
        showRegisterController()
    }
    @objc
    fileprivate func signInButtonClicked() {
        print(#function)
        showMain()
    }
    
    fileprivate func configureTextField() {
        passwordField.delegate = self
        mailField.delegate = self
    }
    
    fileprivate func showRegisterController() {
        let vc = UIStoryboard
            .init(
                name: "Auth",
                bundle: nil
            ).instantiateViewController(
                withIdentifier: "RegisterController"
            ) as? RegisterController ?? RegisterController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func showMain() {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.switchToMain()
        }
    }
    fileprivate func configureField(user: User) {
        mailField.text = user.email
        passwordField.text = user.password
    }

}

extension LoginController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        print(#function, text)
    }
}
extension LoginController: RegisterControllerDelegate {
    func didFinish(user: User) {
        configureField(user: user)
    }
    
}
