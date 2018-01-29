//
//  Concentration.swift
//  TestApp
//
//  Created by Robert Ridley on 28/01/2018.
//  Copyright © 2018 Robert Ridley. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneFaceUpCard = nil
            } else {
                for flippedDownIndex in cards.indices {
                    cards[flippedDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneFaceUpCard = index
            }
        }
    }
    
    init (numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle cards
    }
}
