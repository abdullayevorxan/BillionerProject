//
//  QuestionModel.swift
//  BillionerProject
//
//  Created by Aslanli Faqan on 09.10.24.
//

import Foundation
import UIKit
struct Question {
    let title: String
    var answer: [Answer]
}

struct Answer {
    let title: String
    let correct: Bool
    var colour: UIColor = .clear
}
