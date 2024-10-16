//
//  RegisterController.swift
//  BillionerProject
//
//  Created by Aslanli Faqan on 05.10.24.
//

import UIKit

protocol RegisterControllerDelegate: AnyObject {
    func didFinish(user: User)
}
final class RegisterController: UIViewController {
    
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var surnameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var mailField: UITextField!
    private var user: [User] = []
    weak var delegate: RegisterControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    fileprivate func configureUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        configureButton()
    }
    
    fileprivate func configureButton() {
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        signUpButton.setTitle("Sign Up", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        loginButton.setTitle("Login", for: .normal)
    }
    
    @objc
    fileprivate func signUpButtonClicked() {
        guard checkValidation() else {
            print(#function, "fieldler bosh ola bilmez")
            return
        }
        guard let name = nameField.text,
              let surname = surnameField.text,
              let password = passwordField.text,
              let mail = mailField.text else {return}
        
        let user = User(name: name, surname: surname, email: mail, password: password)
        delegate?.didFinish(user: user)
        navigationController?.popViewController(animated: true)
        
    }
    fileprivate func checkValidation() -> Bool {
        guard let name = nameField.text,
              let surname = surnameField.text,
              let password = passwordField.text,
              let mail = mailField.text
        else {return false}
        return !(name.isEmpty || surname.isEmpty || password.isEmpty || mail.isEmpty)
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        switch sender {
        case surnameField:
            if sender.text?.isEmpty == true {
                surnameField.layer.borderColor = UIColor.red.cgColor
                surnameField.layer.borderWidth = 1.0
            } else if !validateUsername(sender.text ?? "") {
                surnameField.layer.borderColor = UIColor.red.cgColor
                surnameField.layer.borderWidth = 1.0
            } else {
                surnameField.layer.borderColor = UIColor.blue.cgColor
                surnameField.layer.borderWidth = 1.0
            }
            
            
        case nameField:
            if sender.text?.isEmpty == true {
                nameField.layer.borderColor = UIColor.red.cgColor
                nameField.layer.borderWidth = 1.0
            } else if !validatename(sender.text ?? "") {
                nameField.layer.borderColor = UIColor.red.cgColor
                nameField.layer.borderWidth = 1.0
            } else {
                nameField.layer.borderColor = UIColor.blue.cgColor
                nameField.layer.borderWidth = 1.0
            }
            
        case mailField:
            if sender.text?.isEmpty == true {
                mailField.layer.borderColor = UIColor.red.cgColor
                mailField.layer.borderWidth = 1.0
            } else if !validateEmail(sender.text ?? "") {
                mailField.layer.borderColor = UIColor.red.cgColor
                mailField.layer.borderWidth = 1.0
            } else {
                mailField.layer.borderColor = UIColor.blue.cgColor
                mailField.layer.borderWidth = 1.0
            }
            
        case passwordField:
            if sender.text?.isEmpty == true {
                passwordField.layer.borderColor = UIColor.red.cgColor
                passwordField.layer.borderWidth = 1.0
            } else if !validatePassword(sender.text ?? "") {
                passwordField.layer.borderColor = UIColor.red.cgColor
                passwordField.layer.borderWidth = 1.0
            } else {
                passwordField.layer.borderColor = UIColor.blue.cgColor
                passwordField.layer.borderWidth = 1.0
            }
        default:
            break
        }
        
        updateLoginButtonState()
    }
    
    private func resetFieldBorders() {
        [surnameField, nameField, mailField, passwordField].forEach {
            $0?.layer.borderColor = UIColor.clear.cgColor
            $0?.layer.borderWidth = 0.0
        }
    }
    
    private func validateUsername(_ surName: String) -> Bool {
        let regex = "^[A-Za-z]+$"
        let allowedCharacters = NSPredicate(format: "SELF MATCHES %@", regex)
        return allowedCharacters.evaluate(with: surName)
    }
    
    private func validatename(_ name: String) -> Bool {
        let regex = "^[A-Za-z]+$"
        let allowedCharacters = NSPredicate(format: "SELF MATCHES %@", regex)
        return allowedCharacters.evaluate(with: name)
    }
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    private func validatePassword(_ password: String) -> Bool {
        return password.count >= 8
    }
    
    private func isUserExists(fullName: String) -> Bool {
        return user.contains { $0.surname == fullName }
    }
    
    private func addUser(surName: String, name:String, number: String, email: String, password: String) {
        let newUser = User(name: name, surname: surName, email: email, password: password)
        user.append(newUser)
    }
    
    private func clearFields() {
        surnameField.text = ""
        nameField.text = ""
        mailField.text = ""
        passwordField.text = ""
        
        resetFieldBorders()
    }
    
    private func updateLoginButtonState() {
        let issurnameValid = validateUsername(surnameField.text ?? "")
        let isnameValid = validatename(nameField.text ?? "")
        let isEmailValid = validateEmail(mailField.text ?? "")
        let isPasswordValid = validatePassword(passwordField.text ?? "")
        
        let isFormValid = issurnameValid && isnameValid && isEmailValid && isPasswordValid
        signUpButton.isEnabled = isFormValid
    }

    @objc
    fileprivate func loginButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}

