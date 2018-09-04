//
//  ViewController.swift
//  Concentration
//
//  Created by Paula Boules on 9/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var game = Concentration(halfNumberOfCards: (flipButtons.count / 2) )
    
    var flipCounter = 0 {
        didSet{
            flipCounterLabel.text = "Flips: \(flipCounter)"
        }
    }
    
    
    
    @IBOutlet var flipButtons: Array<UIButton>!
    
    @IBOutlet weak var flipCounterLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCounter += 1
        if let cardIndex = flipButtons.index(of: sender){
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
            
        }else {
            print("card is out of collection!")
        }
    }
    
    func updateViewFromModel(){        for index in flipButtons.indices {
        let card = game.cards[index]
        let button = flipButtons[index]
        if !card.isFaceUp {
            button.setTitle("" , for : UIControlState.normal)
            button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji ( for: card) , for : UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
        }
    }
    
    var emojiChoices = ["😪","😟","🍙","🐵","😣","🍘","👶","🚲","😰","🍥","😍","🙀","🐥","😻","🚅","🎷","🙈","🐕","🚭","🎨","😤","😭"]
    
    var emojiDictionary = [Int:String]()
    //var emojiDictionary = Dictionary<Int,String>()
    
    func emoji (for card : Card) -> String {
        // construct the dictionary
        if emojiDictionary[card.identifier] == nil , emojiChoices.count > 0{
            let emojiIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            
            emojiDictionary[card.identifier] = emojiChoices.remove(at: emojiIndex)
        }
        
        // if nil return question mark
        // this case happens when cards # > emojis choices
        return emojiDictionary[card.identifier] ?? "?"
    }
    
}

