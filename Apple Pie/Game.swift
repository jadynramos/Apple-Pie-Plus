//
//  Game.swift
//  Apple Pie
//
//  Created by Student on 1/8/18.
//  Copyright © 2018 Jadyn Ramos. All rights reserved.
//

import Foundation

//Sets the propeties the game contains.
struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    
    //Method that keeps track of which letters were selected during a round.
    var guessedLetters: [Character]
    
    //Recieves character and then adds it to the collections.
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        if !word.characters.contains(letter){
            incorrectMovesRemaining -= 1
        }
    }
    
//Computes a version of the word that hides the missing letters.
    var formattedWord: String {
        var guessedWord = ""
        for letter in word.characters {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}



