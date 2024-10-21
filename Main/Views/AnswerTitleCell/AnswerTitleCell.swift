//
//  AnswerTitleCell.swift
//  BillionerProject
//
//  Created by Aslanli Faqan on 09.10.24.
//

import UIKit

class AnswerTitleCell: UICollectionViewCell {
    @IBOutlet weak var answerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(model: Answer) {
        answerLabel.text = model.title
    }
}
