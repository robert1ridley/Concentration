//
//  Card.swift
//  TestApp
//
//  Created by Robert Ridley on 28/01/2018.
//  Copyright © 2018 Robert Ridley. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var uniqueIdentifierFactory = 0
    
    static func getUniqueCardIdentifier() -> Int {
        uniqueIdentifierFactory += 1
        return uniqueIdentifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueCardIdentifier()
    }
}
