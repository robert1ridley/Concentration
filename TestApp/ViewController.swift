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
    
    var themeIndex = 0
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var topicButtons: [UIButton]!
    
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
    
    @IBAction func topicSelect(_ sender: UIButton) {
        resetEmojiList()
        emoji = [Int:String]()
        themeIndex = topicButtons.index(of: sender)!
        game.restartGame()
        updateViewFromModel()
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    @IBAction func restartButton(_ sender: UIButton) {
        resetEmojiList()
        emoji = [Int:String]()
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
    
    var emojiList = [
        ["🐶", "🐭", "🐰", "🐱", "🦏", "🐘", "🐷", "🐴", "🐍", "🐳"],
        ["👩🏿‍🌾", "👩‍🎤", "👮", "👨🏻‍🏫", "🤡", "👩‍🚀", "🏃🏿", "👩🏼‍⚕️", "🤠", "🚶"],
        ["🍕", "🍝", "🍌", "🥖", "🍜", "🥔", "🍔", "🍟", "🍭", "🍫"]
    ]
    
    var resetList: [[String]] = [[],[],[]]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiList[themeIndex].count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiList[themeIndex].count)))
            resetList[themeIndex].append(emojiList[themeIndex][randomIndex])
            emoji[card.identifier] = emojiList[themeIndex].remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    func resetEmojiList() {
        var count = 0
        for set in resetList {
            for singleEmoji in set {
                resetList[count].remove(at: resetList[count].index(of: singleEmoji)!)
                emojiList[count].append(singleEmoji)
            }
            count = count + 1
        }
    }
}

