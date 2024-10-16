//
//  MainViewController.swift
//  BillionerProject
//
//  Created by Aslanli Faqan on 05.10.24.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var collection: UICollectionView!
    private var questions: [Question] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        generateQuestions()
        configureView()
//        UserDefaultsHelper.setInteger(key: "LoginType", value: 2)
        UserDefaultsHelper.setInteger(key: UserDefaultsKey.loginType.rawValue, value: 2)
    }

    fileprivate func configureView() {
        configureCollection()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    fileprivate func configureCollection() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "AnswerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnswerCollectionViewCell")
    }
    
    fileprivate func generateQuestions() {
        //TODO: should use Json
        questions = [
            Question(
                title: "1+3",
                answer: [
                    Answer(title: "1", correct: false),
                    Answer(title: "2", correct: false),
                    Answer(title: "3", correct: false),
                    Answer(title: "4", correct: true),
                    
                ]
            ),
            Question(
                title: "2+3",
                answer: [
                    Answer(title: "1", correct: false),
                    Answer(title: "2", correct: false),
                    Answer(title: "3", correct: false),
                    Answer(title: "5", correct: true),
                    
                ]
            ),
            Question(
                title: "3+3",
                answer: [
                    Answer(title: "1", correct: false),
                    Answer(title: "2", correct: false),
                    Answer(title: "3", correct: false),
                    Answer(title: "6", correct: true),
                    
                ]
            )
        ]
        
        reloadCollection()
    }
    
    fileprivate func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.collection.reloadData()
        }
    }

}

extension MainViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
        let model = questions[indexPath.row]
        cell.configureCell(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
