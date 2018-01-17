//
//  ViewController.swift
//  Apple Pie
//
//  Created by Student on 12/31/16.
//  Copyright © 2016 Jadyn Ramos. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    //List of words that the player needs to guess.
    var listOfWords = ["apple", "pizza", "beyonce", "dog", "koala", "fries", "polarbear", "soccer", "school", "christmas"]
    
    //Number of trys a player gets each round.
    let incorrectMovesAllowed = 7

    //Keeps track of amount of wins and losses.
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var correctGuess = 0 {
        didSet{
            newRound()
        }
    }
    
   //Creates a label to keep track of the points for each correct guess.
    @IBOutlet weak var scorePoints: UILabel!
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    //Determines which leter was selected and whether or not it matches to correct letter.
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    

    
    //Checks the game state to see if a win or loss has occured.
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            correctGuess += 5
        } else {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var currentGame: Game!
    
    //Starts a new round and creates a new instance of the game.
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining:incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    //Function uses the parameters to enable or disable the collection of buttons.
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI(){
        let letter = currentGame.formattedWord.characters.map { String($0)}

        //for letter in currentGame.formattedWord.characters {
        //letters.append(String(letter))

        //Adds a space between the lines indicating how many letters are in the word. 
        let wordWithSpacing = letter.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")

        scorePoints.text = "Score: \(correctGuess)"
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



