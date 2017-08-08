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
    
    var ball = SKSpriteNode()
    var main = SKSpriteNode()
    var enemy = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)

        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
    }
    
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
        
        let enemyMoveAction = SKAction.moveTo(x: ball.position.x, duration: 0.3)
        enemy.run(enemyMoveAction)
        
        
        
        
        
    }
    
    
    
    
    
}
