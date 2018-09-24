//
//  ViewController.swift
//  TicTacToeGame
//
//  Created by К.К. on 23.09.18.
//  Copyright © 2018 TeamK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        winnerLabel.isHidden = true
        playAgain.isHidden = true
        
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 1000, y: winnerLabel.center.y)
        playAgain.center = CGPoint(x: playAgain.center.x - 1000, y: playAgain.center.y)
    }
    
    var activePlayer:Int = 1
    var activeGame = true
    var movesCounter = 0
    var gameState:[Int] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    @IBAction func buttonPressed(_ sender: Any) {
        let senderWithTag = sender as AnyObject
        
        if gameState[senderWithTag.tag!-1] == 0 && activeGame  {
            
            if activePlayer == 1 {
                gameState[senderWithTag.tag!-1] = 1
                activePlayer = 2
                movesCounter += 1
                senderWithTag.setImage(UIImage(named: "circle.png"), for: UIControl.State.normal )
            } else {
                gameState[senderWithTag.tag!-1] = 2
                activePlayer = 1
                movesCounter += 1
                senderWithTag.setImage(UIImage(named: "cross.png"), for: UIControl.State.normal )
            }
            
            // game over with a winner, check
            for combination in winningCombinations {
                if ( gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] ) {
                    
                    // there is a winner
                    activeGame = false
                    
                    winnerLabel.isHidden = false
                    playAgain.isHidden = false
                    
                    if gameState[combination[0]] == 1 {
                        winnerLabel.text = "Circles won the game!"
                    } else {
                        winnerLabel.text = "Crosses won the game!"
                    }
                    
                    UIView.animate(withDuration: 1, animations: {
                        self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 1000, y: self.winnerLabel.center.y)
                        self.playAgain.center = CGPoint(x: self.playAgain.center.x + 1000, y: self.playAgain.center.y)
                    })
                    
                }
            }
            
            // game over with no winner, check
            if movesCounter == 9 && activeGame {
                // there is no winner
                activeGame = false
                
                winnerLabel.isHidden = false
                playAgain.isHidden = false
                
                winnerLabel.text = "Nobody won the game!"
                
                UIView.animate(withDuration: 1, animations: {
                    self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 1000, y: self.winnerLabel.center.y)
                    self.playAgain.center = CGPoint(x: self.playAgain.center.x + 1000, y: self.playAgain.center.y)
                })
                
            }
            
        }
        // print(senderWithTag.tag!)
    }
    
    @IBAction func PlayAgain(_ sender: Any) {
        activePlayer = 1
        activeGame = true
        movesCounter = 0
        gameState = [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
        
        for tag in 1..<10 {
            if let button = view.viewWithTag(tag) as? UIButton {
                button.setImage(nil, for: UIControl.State.normal )
            }
        }
        
        winnerLabel.isHidden = true
        playAgain.isHidden = true
        
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 1000, y: winnerLabel.center.y)
        playAgain.center = CGPoint(x: playAgain.center.x - 1000, y: playAgain.center.y)
        
    }
    

}

