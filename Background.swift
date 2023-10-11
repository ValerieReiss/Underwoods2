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
        
        let move = SKAction.moveTo(x: self.position.x-31500, duration: 50)
         
         run(move)
        
        /*
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 100, y: 0))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 0.00001)
        //let sequence = SKAction.sequence([movement, .removeFromParent()]) //stop or show endpic
        self.run (movement)
         */
        
    }
    
    func run(){
        let runn = SKAction.moveTo(x: self.position.x-400, duration: 0.3)
        runn.timingFunction = {time in return simd_smoothstep(0, 1, time)}
        self.run(runn)
    }
    
    func endstation() -> Bool{
        print("\(self.position.x)")
        
        let endpunkt = CGPoint(x:-14335, y: 0)

        if(self.position.x <= endpunkt.x){
               return true
            }
        else {
            return false
        }
        }

    
}
