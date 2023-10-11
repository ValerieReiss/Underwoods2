//
//  Background.swift
//  Underwoods
//
//  Created by Valerie on 11.10.23.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode{
    
    init(){
        
        let texture = SKTexture(imageNamed: "bgMoving")
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        self.xScale = 1.0
        self.yScale = 1.0
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = -1
        
        let body:SKPhysicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0, size: texture.size() )
        
        self.physicsBody = body
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        
        self.physicsBody?.contactTestBitMask = CollisionType.bone.rawValue | CollisionType.crystal.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func move(){
        let move = SKAction.moveTo(x: self.position.x-200, duration: 0.8)
        
        run(move)
    }
    
    func run(){
        let runn = SKAction.moveTo(x: self.position.x-200, duration: 0.3)
            //bli.timingFunction = {time in return simd_smoothstep(0, 1, time)}
        run(runn)
    }
}
