//
//  QuestionHeaderView.swift
//  BillionerProject
//
//  Created by Aslanli Faqan on 09.10.24.
//

import UIKit

class QuestionHeaderView: UICollectionReusableView {
    @IBOutlet private weak var questionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureView(model: Question) {
        questionLabel.text = model.title
    }
}
