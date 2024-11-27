//
//  MainViewController.swift
//  BillionerProject
//
//  Created by Aslanli Faqan on 05.10.24.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var collection: UICollectionView!
    @IBOutlet private weak var nextQuestionBUtton: UIButton!
    private var result:[Answer] = []
    private var questions: [Question] = []
    
    var correctCounter = 0
    var currentQuestionIndex = 0
    var scores = 0
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
        collection.isScrollEnabled = false
        collection.register(UINib(nibName: "AnswerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnswerCollectionViewCell")
    }
    
    fileprivate func generateQuestions() {
        //TODO: should use Json
        questions = [
            Question(
                title: "150/3",
                answer: [
                    Answer(title: "1", correct: false),
                    Answer(title: "2", correct: false),
                    Answer(title: "3", correct: false),
                    Answer(title: "50", correct: true),
                    
                ]
            ),
            Question(
                title: "120/3",
                answer: [
                    Answer(title: "1", correct: false),
                    Answer(title: "2", correct: false),
                    Answer(title: "3", correct: false),
                    Answer(title: "40", correct: true),
                    
                ]
            ),
            Question(
                title: "180/3",
                answer: [
                    Answer(title: "1", correct: false),
                    Answer(title: "2", correct: false),
                    Answer(title: "3", correct: false),
                    Answer(title: "60", correct: true),
                    
                ]
            ),
            Question(
                title: "2+3",
                answer: [
                    Answer(title: "1", correct: false),
                    Answer(title: "5", correct: true),
                    Answer(title: "3", correct: false),
                    Answer(title: "4", correct: false),
                    
                ]
            ), Question(
                title: "23+22",
                answer: [
                    Answer(title: "1", correct: false),
                    Answer(title: "2", correct: false),
                    Answer(title: "3", correct: false),
                    Answer(title: "45", correct: true),
                    
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
    fileprivate func checkAnswer(answer: Answer) {
        result.append(answer)
        print(#function, result.filter({$0.correct}).count)
        
        scores = result.filter({$0.correct}).count
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
        cell.callback = { [weak self] answer in
            self?.checkAnswer(answer: answer)
        }
        return cell
    }
    
    @IBAction func nextQuestionButtonTapped(_ sender: UIButton) {
            
           // let indexPath = IndexPath(row: 0, section: 0)
          // if let cell = collection.cellForItem(at: indexPath) as? AnswerTitleCell {
          // let answer = cell.answerLabel.text
    //    //    print(answer)
          // }
            currentQuestionIndex += 1
        //print(currentQuestionIndex)
            
            
            
            
            if currentQuestionIndex < questions.count {
                let indexPath = IndexPath(item: currentQuestionIndex, section: 0)
                collection.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
                if currentQuestionIndex == questions.count-1{
                    nextQuestionBUtton.setTitle("Submit", for:.normal)

                    
                }
            } else {
                
                UserDefaults.standard.setValue(scores, forKey: "scores")
                
                let nextVC = storyboard?.instantiateViewController(withIdentifier: "ResultViewControllerTest") as! ResultViewControllerTest
                navigationController?.pushViewController(nextVC, animated: true)
                navigationController?.navigationBar.barTintColor = UIColor.green
           
            }
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 48, height: collectionView.frame.height - 24)
    }
   
}
