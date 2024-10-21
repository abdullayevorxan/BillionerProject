//
//  ResultViewController.swift
//  BillionerProject
//
//  Created by Orkhan Abdullayev on 18.10.24.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        let name = UserDefaults.standard.string(forKey: "name")
        let surname = UserDefaults.standard.string(forKey: "surname")
        let email = UserDefaults.standard.string(forKey: "email")
        
        nameLabel.text = name ?? ""
        surnameLabel.text = surname ?? ""
        emailLabel.text = email ?? ""

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutButtonClicked(_ sender: Any) {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate{
            scene.switchToLogin()
        }
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "surname")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.synchronize()
    }
    

}
