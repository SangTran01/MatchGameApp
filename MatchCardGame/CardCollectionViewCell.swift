//
//  CardCollectionViewCell.swift
//  MatchCardGame
//
//  Created by Sang Tran on 2022-09-17.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    //expose both cards here
    
    @IBOutlet weak var cardFront: UIImageView!
    @IBOutlet weak var cardBack: UIImageView!
    
    var currentCard : Card?
    
    func configureCard(_ card: Card)
    {
        if (card.isMatched)
        {
            cardFront.alpha = 0
            cardBack.alpha = 0
            return
        } else
        {
            cardFront.alpha = 1
            cardBack.alpha = 1
        }
        
        self.currentCard = card
        cardFront.image = UIImage(named: card.cardName)
        
        if (card.isFlipped)
        {
            flipUp(0)
        } else
        {
            flipDown(0)
        }
    }
    
    func flipUp(_ speed: Double = 0.3)
    {
        UIView.transition(from: cardBack, to: cardFront, duration: speed, options: [
            .showHideTransitionViews,.transitionFlipFromLeft])
        
        //set state flipped
        currentCard?.isFlipped = true
    }
    
    func flipDown(_ speed: Double = 0.3)
    {
        UIView.transition(from: cardFront, to: cardBack, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft])
        currentCard?.isFlipped = false
    }
    
    func remove()
    {
        self.cardBack.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.cardFront.alpha = 0
        })
    }
}
