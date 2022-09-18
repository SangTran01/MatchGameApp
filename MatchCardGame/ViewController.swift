//
//  ViewController.swift
//  MatchCardGame
//
//  Created by Sang Tran on 2022-09-16.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    var model = CardModel()
    var cards = [Card]()
    
    var firstSelectedCard: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cards = model.getCards()
        
        //set collectionView datasource
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
    }

    //MARK: CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return num of cards
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //do not recreate new cell, need to reuse from
        //collectionView will resuse or create new one
//        var cell = CardCollectionViewCell()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //will display
        let cardCell = cell as? CardCollectionViewCell
        cardCell?.configureCard(cards[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //get cell selected
        if let cell = (collectionView.cellForItem(at: indexPath)) {
            
            //found cell do something
            let cardCell = cell as? CardCollectionViewCell
            
            let card = cards[indexPath.row]
            
            if (card.isMatched)
            {
                return
            }
            
            if (card.isFlipped == false)
            {
                cardCell?.flipUp()
            }
            
            //update first selected
            if (firstSelectedCard == nil)
            {
                firstSelectedCard = indexPath
            } else
            {
                //check match
                let firstCard = cards[firstSelectedCard!.row]
                
                if (firstCard.cardName == card.cardName)
                {
                    print("match!!")
                    
                    firstCard.isMatched = true
                    card.isMatched = true
                    
                    let firstCell = collectionView.cellForItem(at: self.firstSelectedCard!) as? CardCollectionViewCell
                    
                    firstCell?.remove()
                    cardCell?.remove()
                    self.firstSelectedCard = nil
                                       
                } else
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        print("no match. Flip both back down")
                        firstCard.isFlipped = false
                        card.isFlipped = false
                        
                        let firstCell = collectionView.cellForItem(at: self.firstSelectedCard!) as? CardCollectionViewCell
                        
                        firstCell?.flipDown()
                        cardCell?.flipDown()
                        self.firstSelectedCard = nil
                     }
                }
            }
            
        }
    }
}

