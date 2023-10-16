//
//  Crystal.swift
//  Underwoods
//
//  Created by Valerie on 13.10.23.
//

import Foundation
import SpriteKit
import GameplayKit

class Crystal: SKSpriteNode, SKPhysicsContactDelegate{
    var randomCrystal = Int.random(in: 0..<8)
    let arrayCrystals = ["obCrystal0", "obCrystal1", "obCrystal2", "obCrystal3", "obCrystal4", "obCrystal5", "obCrystal6", "obCrystal7"]
    
   // var type: Int
    
    init(){
        let texture = SKTexture(imageNamed: arrayCrystals[randomCrystal])
        super.init(texture: texture, color: .white, size: texture.size())
        
        self.name = "crystal"
        self.zPosition = 3
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.allowsRotation = false
        
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        
        self.setScale(0.5)
        
        self.physicsBody?.contactTestBitMask = ColliderType.player.rawValue
        self.physicsBody?.categoryBitMask  = ColliderType.crystal.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.crystal.rawValue

       
        self.position = CGPoint(x: 2000, y: Int.random(in: 900..<1150))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("rien compris")    }
    
    func move(){
        let hin = SKAction.moveTo(x: 0, duration: 6.0)
        let sequence = SKAction.sequence([hin, .removeFromParent()])
        self.run (sequence)
        
    }
}
