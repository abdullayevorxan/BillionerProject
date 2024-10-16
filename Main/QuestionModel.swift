//
//  QuestionModel.swift
//  BillionerProject
//
//  Created by Aslanli Faqan on 09.10.24.
//

import Foundation
struct Question {
    let title: String
    let answer: [Answer]
}

struct Answer {
    let title: String
    let correct: Bool
}
