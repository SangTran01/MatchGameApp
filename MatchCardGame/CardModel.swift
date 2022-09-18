//
//  CardModel.swift
//  MatchCardGame
//
//  Created by Sang Tran on 2022-09-17.
//

import Foundation

class CardModel
{
    var cards = [Card]()
    func getCards() -> [Card] {
        
        while cards.count < 16
        {
            let random = Int.random(in: 1...13)
            let cardName = "card\(random)"
            if (!cards.contains(where: {x in x.cardName == cardName}))
            {
                //add
                cards.append(Card("card\(random)", false, false))
                cards.append(Card("card\(random)", false, false))
            }
        }
        print(cards.count)
        //randomize the array
        cards.shuffle()
        return cards
    }
}
