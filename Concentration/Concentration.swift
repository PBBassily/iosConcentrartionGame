//
//  Concentration.swift
//  Concentration
//
//  Created by Paula Boules on 9/3/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import Foundation
class Concentration {
    
    var cards = Array<Card>()
    
    func flipCard(){
        
    }
    
    init(halfNumberOfCards : Int){
        for _ in 1 ... halfNumberOfCards {
            let card = Card()
            cards += [card , card]
            // alternative : cards.apend(card) (twice)
        }
        
        
        var shuffeled = Array<Card>()
        
        while cards.count > 0 {
            shuffeled.append(
                cards.remove(at: Int(arc4random_uniform(UInt32(cards.count)))))
        }
        cards = shuffeled	
    }
    var onlyFacedUpCardIndex :Int?
    
    func chooseCard(at index : Int){
        if !cards[index].isMatched{
            if onlyFacedUpCardIndex != nil , onlyFacedUpCardIndex != index {
                // check match
                if cards[onlyFacedUpCardIndex!].identifier == cards[index].identifier {
                    
                    cards[onlyFacedUpCardIndex!].isMatched = true
                    cards[index].isMatched = true
                }
                // not  matched for matched
                onlyFacedUpCardIndex = nil
                cards[index].isFaceUp = true
            } else {
             // two wrong cards or no cards
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                cards[index].isFaceUp = true
                onlyFacedUpCardIndex = index
            }
        }
    }
}
