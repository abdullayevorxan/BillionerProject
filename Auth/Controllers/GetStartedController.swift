//
//  GetStartedController.swift
//  BillionerProject
//
//  Created by Aslanli Faqan on 05.10.24.
//

import UIKit
final class GetStartedController: UIViewController {
    @IBOutlet private weak var submitButton: UIButton!
    private var counter = UserDefaultsHelper.getInteger(key: UserDefaultsKey.userLoginStep.rawValue)
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
//        UserDefaultsHelper.setInteger(key: "LoginType", value: 0)
//        UserDefaultsHelper.setInteger(key: UserDefaultsKey.loginType.rawValue, value: 0)
        counter += 1
        UserDefaultsHelper.setInteger(key: UserDefaultsKey.userLoginStep.rawValue, value: counter)
        if counter > 3 {
            UserDefaultsHelper.setInteger(key: UserDefaultsKey.loginType.rawValue, value: 1)
        } else {
            UserDefaultsHelper.setInteger(key: UserDefaultsKey.loginType.rawValue, value: 0)
        }
    }
    
    fileprivate func configureButton() {
        submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
        submitButton.setTitle("Get Started", for: .normal)
    }
    
    fileprivate func configureUI() {
        
    }
    @objc
    fileprivate func submitButtonClicked() {
        showLoginController()
    }
    
    fileprivate func showLoginController() {
        
        
        let vc = UIStoryboard
            .init(
                name: "Auth",
                bundle: nil
            ).instantiateViewController(withIdentifier: "LoginController") as? LoginController ?? LoginController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

