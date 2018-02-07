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
    
//    var emojiList = Emoji()
    
    var indexOfOneFaceUpCard: Int?
    
    var flipCount = 0
    
    func chooseCard(at index: Int){
        if cards[index].reset == true {
            cards[index].reset = false
        }
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
        //Shuffle cards
        if (cards.count > 0) {
            var newCardArray = [Card]()
            for _ in cards {
                let randomItem = arc4random_uniform(UInt32(cards.count))
                let ChosenItem = cards[Int(randomItem)]
                newCardArray.append(ChosenItem)
                cards.remove(at: Int(randomItem))
            }
            cards = newCardArray
        }
    }
    
    func newFlip() {
        flipCount = flipCount + 1
    }
    
    func restartGame () {
        flipCount = 0
        var count = 0
        for _ in cards {
            cards[count].reset = true
            cards[count].isMatched = false
            cards[count].isFaceUp = false
            count = count + 1
        }
        if (cards.count > 0) {
            var newCardArray = [Card]()
            for _ in cards {
                let randomItem = arc4random_uniform(UInt32(cards.count))
                let ChosenItem = cards[Int(randomItem)]
                newCardArray.append(ChosenItem)
                cards.remove(at: Int(randomItem))
            }
            cards = newCardArray
        }
    }
}
