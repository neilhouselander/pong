//
//  GameScene.swift
//  Pong
//
//  Created by Neil Houselander on 06/08/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.


//STUFF TO ADD
// GAME OVER SCENE - WHO WON & RESET
// FIX RANDOMNESS OF BALL LAUNCH - USE THE ADD SCORE FUNCTION TO ACHIEVE

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //create the sprite variables
    var ball = SKSpriteNode()
    var main = SKSpriteNode()
    var enemy = SKSpriteNode()
    
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    
    //score array - use rather than 2 separate variables
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        

        //link variables with spritenodes
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        

        //create a frame which follows the frame of the screen so we can apply physics to it
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)

        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        //run start game to set scores to zero
        startGame()
        
    }
    
    func startGame() {
        
        score = [0,0]
        
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
        
        //set initial velocity and direction for the ball node
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
    }
    
    //function to add scores and reset ball to centre when a point is scored, set velocity back to zero, then start again
    func addScore(playerWhoWon: SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            
            score[0] += 1
            
        }
            
        else if playerWhoWon == enemy {
            
            score[1] += 1

        }
        
        //add speed depending on score - so if score for either player is 5 then speed up
        
        if (score[0] >= 5 && score[0] < 10 ) || (score[1] >= 5 && score[1] < 10) {
            ball.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 40))
        }
        
        else if (score[0] >= 10 || score[1] >= 10) {
            ball.physicsBody?.applyImpulse(CGVector(dx: 60, dy: 60))
        }
            
        else {
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        
        
        //update scores on screen
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
        
        
    }
    
    //use touches to move my paddle - get location of touch and then move main paddle to that x location
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            let mainMoveAction = SKAction.moveTo(x: location.x, duration: 0.1)
            
            if currentGameType == gameType.player2 {
                
                if location.y > 0 {
                    
                    enemy.run(mainMoveAction)
                    
                }
                
                if location.y < 0 {
                    
                    main.run(mainMoveAction)
                    
                }
            }
            else {
                
                main.run(mainMoveAction)
                
            }
            
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            let mainMoveAction = SKAction.moveTo(x: location.x, duration: 0.1)
            
            if currentGameType == gameType.player2 {
                
                if location.y > 0 {
                    
                    enemy.run(mainMoveAction)
                    
                }
                
                if location.y < 0 {
                    
                    main.run(mainMoveAction)
                    
                }
            }
            
            else {
                main.run(mainMoveAction)
            }
            
        }

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        //every time the game updates (60 times per second) run an action for the enemy paddle to track the ball
        
        switch currentGameType {
            
        case gameType.easy:
            let enemyMoveAction = SKAction.moveTo(x: ball.position.x, duration: 0.8)
            enemy.run(enemyMoveAction)
            
            break
            
        case gameType.medium:
            let enemyMoveAction = SKAction.moveTo(x: ball.position.x, duration: 0.5)
            enemy.run(enemyMoveAction)
            
            break
            
        case gameType.hard:
            let enemyMoveAction = SKAction.moveTo(x: ball.position.x, duration: 0.3)
            enemy.run(enemyMoveAction)
            
            break
            
        case gameType.player2:
            
            break
            
            
        }

        
        //if the balls y position is less than main then enemy scores a point - run addScore function & pass in enemy parameter
        if ball.position.y <= main.position.y - 70 {
            
            addScore(playerWhoWon: enemy)
            
        }
        else if ball.position.y >= enemy.position.y + 70 {
            
            addScore(playerWhoWon: main)
            
        }

        
    }
    
    
}
