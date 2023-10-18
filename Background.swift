//
//  Background.swift
//  Underwoods
//
//  Created by Valerie on 11.10.23.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode{
    let arrayBackgrounds = ["bgMoving", "bgMoving1", "bgMoving2"]
    
        var type: Int
    init(type: Int){
        self.type = type
        
        let texture = SKTexture(imageNamed: arrayBackgrounds[type])
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        self.xScale = 1.0
        self.yScale = 1.0
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = -1
        
        let body:SKPhysicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0, size: texture.size() )
        
        self.physicsBody = body
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("rien compris")
        }
    
    func move(){
        let move = SKAction.moveTo(x: self.position.x-31500, duration: 95)
        //let move = SKAction.moveTo(x: self.position.x-200, duration: 0.5)
        run(move)
    }
    
    func run(){
        let runn = SKAction.moveTo(x: self.position.x-500, duration: 0.5)
        //runn.timingFunction = {time in return simd_smoothstep(0, 1, time)}
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
