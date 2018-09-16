//
//  ViewController.swift
//  Concentration
//
//  Created by Paula Boules on 9/2/18.
//  Copyright © 2018 Paula Boules. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    
    
    
    lazy var game = Concentration(halfNumberOfCards: ((flipButtons.count + 1) / 2) )
    
    var flipCounter = 0 {
        didSet{
            
            flipCounterLabel.text = traitCollection.verticalSizeClass == .compact ? "Flips:\n \(flipCounter)" :  "Flips: \(flipCounter)"
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let temp = flipCounter
        flipCounter = temp // to incoke didset
    }
    
    @IBOutlet var flipButtons: Array<UIButton>!
    var visibleButton : [UIButton]! {
        
            return flipButtons.filter({!$0.isHidden})
        
    }
    override func viewDidLayoutSubviews() {
        updateViewFromModel()
    }
    
    @IBOutlet weak var flipCounterLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCounter += 1
        if let cardIndex = visibleButton.index(of: sender){
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
            
        }else {
            print("card is out of collection!")
        }
    }
    
    func updateViewFromModel(){
        guard flipButtons != nil else { return }
        for index in visibleButton.indices {
            let card = game.cards[index]
            let button = visibleButton[index]
            if !card.isFaceUp {
                button.setTitle("" , for : UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            } else {
                button.setTitle(emoji ( for: card) , for : UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
        }
    }
    var emojiChoices : [String] = []
    var theme : [String]? {
        didSet{
        emojiChoices = theme! 
        emojiDictionary = [:]
        updateViewFromModel()
        }}
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

