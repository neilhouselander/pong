//
//  GameScene.swift
//  Pong
//
//  Created by Neil Houselander on 06/08/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //create the sprite variables
    var ball = SKSpriteNode()
    var main = SKSpriteNode()
    var enemy = SKSpriteNode()
    
    //score array - use rather than 2 separate variables
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        //run start game to set scores to zero
        startGame()
        
        //link variables with spritenodes
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        
        //set initial velocity and direction for the ball node
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        //create a frame which follows the frame of the screen so we can apply physics to it
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)

        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
    }
    
    func startGame() {
        
        score = [0,0]
        
        
    }
    
    //function to add scores and reset ball to centre when a point is scored, set velocity back to zero, then start again
    func addScore(playerWhoWon: SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            
        }
        else if playerWhoWon == enemy {
            
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
            
        }
        
        print(score)
        
        
    }
    
    //use touches to move my paddle - get location of touch and then move main paddle to that x location
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            let mainMoveAction = SKAction.moveTo(x: location.x, duration: 0.1)
            main.run(mainMoveAction)
            
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            let mainMoveAction = SKAction.moveTo(x: location.x, duration: 0.1)
            main.run(mainMoveAction)
            
        }

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        //every time the game updates (60 times per second) run an action for the enemy paddle to track the ball
        let enemyMoveAction = SKAction.moveTo(x: ball.position.x, duration: 0.4)
        enemy.run(enemyMoveAction)
        
        //if the balls y position is less than main then enemy scores a point - run addScore function & pass in enemy parameter
        if ball.position.y <= main.position.y - 70 {
            
            addScore(playerWhoWon: enemy)
            
        }
        else if ball.position.y >= enemy.position.y + 70 {
            
            addScore(playerWhoWon: main)
            
        }

        
    }
    
    
}
