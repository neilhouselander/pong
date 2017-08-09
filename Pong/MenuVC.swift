//
//  MenuVC.swift
//  Pong
//
//  Created by Neil Houselander on 09/08/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class MenuVC : UIViewController {
    
    @IBAction func twoPlayerButton(_ sender: Any) {
        
        moveToGame(game: gameType.player2)
        
    }
    
    
    @IBAction func easyButton(_ sender: Any) {
        
        moveToGame(game: gameType.easy)
        
    }
    
    
    @IBAction func mediumButton(_ sender: Any) {
        
        moveToGame(game: .medium)
        
    }
    
    @IBAction func hardButton(_ sender: Any) {
        
        moveToGame(game: .hard)
        
    }
    
    func moveToGame(game: gameType) {
        
        let gameVc = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVc, animated: true)
        
    }
    
    
    
    
    
}
