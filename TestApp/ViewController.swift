//
//  ViewController.swift
//  TestApp
//
//  Created by Robert Ridley on 28/01/2018.
//  Copyright © 2018 Robert Ridley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration (numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchButton(_ sender: UIButton) {
        game.newFlip()
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("Chosen card not in list!")
        }
    }
    
    
    @IBAction func restartButton(_ sender: UIButton) {
        game.restartGame()
        flipCountLabel.text = "Flips: \(game.flipCount)"
        updateViewFromModel()
    }
    
    func updateViewFromModel(){
        flipCountLabel.text = "Flips: \(game.flipCount)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0): #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiList = ["🐶", "🐭", "🐰", "🐱", "🦏", "🐘", "🐷", "🐴", "🐍", "🐳"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiList.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiList.count)))
            emoji[card.identifier] = emojiList.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

