//
//  Bone.swift
//  Underwoods
//
//  Created by Valerie on 13.10.23.
//

import Foundation
import SpriteKit
import GameplayKit

class Bone: SKSpriteNode, SKPhysicsContactDelegate{
    var randomBone = Int()
    let arrayBones = ["obBone0", "obBone1", "obBone2", "obBone3", "obBone4", "obBone5"]
    
    init(){
        let texture = SKTexture(imageNamed: arrayBones[randomBone])
        super.init(texture: texture, color: .white, size: texture.size())
        
        self.name = "bone"
        self.zPosition = 3
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.contactTestBitMask = ColliderType.player.rawValue
        self.physicsBody?.categoryBitMask  = ColliderType.bone.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.bone.rawValue
        
        self.setScale(0.7)
        self.position = CGPoint(x: 2000, y: Int.random(in: 200..<350))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("rien compris")    }
    
    func move(){
        let hin = SKAction.moveTo(x: 0, duration: 6.0)
        let sequence = SKAction.sequence([hin, .removeFromParent()])
        self.run (sequence)
    }
}
