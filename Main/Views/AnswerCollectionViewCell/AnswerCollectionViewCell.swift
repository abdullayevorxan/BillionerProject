//
//  AnswerCollectionViewCell.swift
//  BillionerProject
//
//  Created by Aslanli Faqan on 09.10.24.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var collection: UICollectionView!
    private var question: Question?
    var oneTouch = false
    var callback: ((Answer) -> Void)?
    var checkAnswer = true
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollection()
        // Initialization code
    }
    
    fileprivate func configureCollection() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "AnswerTitleCell", bundle: nil), forCellWithReuseIdentifier: "AnswerTitleCell")
        collection.register(UINib(nibName: "QuestionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QuestionHeaderView")
        
    }
    
    func configureCell(model: Question) {
        question = model
        reloadCollection()
    }
    
    fileprivate func setColor(index: Int) {
        guard let answer = question?.answer[index] else {return}
        question?.answer[index].colour = answer.correct ? .green : .red
        
        
        reloadCollection()
    }
    
    
    fileprivate func reloadCollection() {
        DispatchQueue.main.async { [weak self] in
            self?.collection.reloadData()
        }
    }
}
    



extension AnswerCollectionViewCell: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        question?.answer.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerTitleCell", for: indexPath) as! AnswerTitleCell
        guard let answer = question?.answer[indexPath.row] else {return UICollectionViewCell()}
        cell.configureCell(model: answer)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 10, height: 50 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height/3)
    }
    
    
/*    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !oneTouch else {return}
        
        oneTouch = true
        guard let answer = question?.answer[indexPath.row] else {return}
        setColor(index: indexPath.row)
        callback?(answer)
        print(#function, answer)
    }
 */
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "QuestionHeaderView", for: indexPath) as! QuestionHeaderView
            guard let model = question else {return UICollectionReusableView()}
            header.configureView(model: model)
            return header
        default:
            return UICollectionReusableView()
        }
        
    }
    
  /*  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let answer = question?.answer[indexPath.row] else {return}
        print(#function, answer, indexPath.row)
    }
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let answer = question?.answer[indexPath.row] else {return}
            //setColor(index: indexPath.row)
            let cell = collection.cellForItem(at: indexPath) as! AnswerTitleCell
            
            if checkAnswer {
                
                cell.answerLabel.backgroundColor = answer.correct ? .green : .red
                //reloadCollection()
                 checkAnswer = false
            }
            callback?(answer)
            print(#function, answer, indexPath.row)
        }
}

