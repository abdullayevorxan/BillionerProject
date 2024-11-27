//
//  ResultViewControllerTest.swift
//  BillionerProject
//
//  Created by Orkhan Abdullayev on 22.10.24.
//

import UIKit

class ResultViewControllerTest: UIViewController {
    @IBOutlet private weak var curveView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curveViewCheck()
        setResult()
        
    }
    
    func curveViewCheck(){
        curveView.layer.cornerRadius = 10
      
    }
  
    
    func setResult() {
 
        let score = UserDefaults.standard.string(forKey: "scores")
        
        

        scoreLabel.text = score
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
