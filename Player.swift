//
//  Player.swift
//  Balloonatics
//
//  Created by Valerie on 08.03.23.
//

import Foundation
import SpriteKit
/*
struct PhysicsCategory {
    //static let None         : UInt32 = 0
    //static let All          : UInt32 = UInt32.max
    static let player       : UInt32 = 0x1 << 1
    static let Enemy        : UInt32 = 0x1 << 2
    static let Star         : UInt32 = 0x1 << 4
    static let Balloon      : UInt32 = 0x1 << 8
    static let create1      : UInt32 = 0x1 << 16
    static let create2      : UInt32 = 0x1 << 32
    static let create3      : UInt32 = 0x1 << 64
}
*/
class Player: SKSpriteNode{

init(){

    let texture = SKTexture(imageNamed: "player-front0")

    super.init(texture: texture, color: UIColor.clear, size: texture.size())

    self.xScale = 1.4
    self.yScale = 1.4
    
    self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    self.zPosition = 5
    
    
    let body:SKPhysicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0, size: texture.size() )

    
    self.physicsBody = body
    self.physicsBody?.allowsRotation = false
    
    self.physicsBody?.isDynamic = true
    self.physicsBody?.affectedByGravity = true
    self.physicsBody!.categoryBitMask = ColliderType.player.rawValue
    self.physicsBody!.collisionBitMask = ColliderType.player.rawValue
    self.physicsBody!.contactTestBitMask = ColliderType.bone.rawValue | ColliderType.crystal.rawValue
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}

func boundsCheckPlayer(playableArea: CGRect){
    if(self.position.x <= 900){self.position.x = 900}
    if(self.position.x >= 1200){self.position.x = 1200}
    if(self.position.y >= 600){self.position.y = 400}
}

func movePlayerBy(dxVectorValue: CGFloat, dyVectorValue: CGFloat, duration: TimeInterval)->(){

    print("move player")
    let moveActionVector = CGVectorMake(dxVectorValue, dyVectorValue)
    let movePlayerAction = SKAction.applyForce(moveActionVector, duration: 0.001/duration)
    self.run(movePlayerAction)
}

func stopMoving() {
    let player0 = SKTexture(imageNamed: "player0")
    let animation = SKAction.animate(with: [player0], timePerFrame: 0.1)
    run(animation)
}

func moveRight(){
    let player0 = SKTexture(imageNamed: "player0")
    let player2 = SKTexture(imageNamed: "player2")
    let player3 = SKTexture(imageNamed: "player3")
    let animation = SKAction.animate(with: [player0, player2, player0, player3, player0], timePerFrame: 0.1)
    let repeated = SKAction.repeat(animation, count: 1)
    run(repeated)
}

func runRight(){
        let playerrun1 = SKTexture(imageNamed: "player-run1")
        let playerrun2 = SKTexture(imageNamed: "player-run2")
        let player0 = SKTexture(imageNamed: "player0")
        let animation = SKAction.animate(with: [playerrun1, player0, playerrun2, player0], timePerFrame: 0.1)
        //let makePlayerRun = SKAction.repeatForever(animation)
        run(animation)
}
    
    func jump(){
        //let action = SKAction.setTexture(SKTexture(imageNamed: "player-jump"), resize: true)
        let playerjump = SKTexture(imageNamed: "player-jump")
        let animation = SKAction.animate(with: [playerjump], timePerFrame: 0.4)
        run(animation)
    }
    
    func normal(){
        let action = SKAction.setTexture(SKTexture(imageNamed: "player0"), resize: true)
        run(action)
    }
    
    func wave(){
        let playerwave1 = SKTexture(imageNamed: "player-wave1")
        let playerwave2 = SKTexture(imageNamed: "player-wave2")
        let playerwave0 = SKTexture(imageNamed: "player-wave0")
        let playerfront0 = SKTexture(imageNamed: "player-front0")
        let animation = SKAction.animate(with: [playerwave0, playerwave1, playerwave2, playerwave1, playerwave0, playerfront0], timePerFrame: 0.1)
        run(animation)
    }
    
    func won(){
        let playerwon0 = SKTexture(imageNamed: "player-won0")
        let playerwon1 = SKTexture(imageNamed: "player-won1")
        let playerfront0 = SKTexture(imageNamed: "player-front0")
        
        let animation = SKAction.animate(with: [playerwon0, playerwon1, playerwon0, playerwon1, playerwon0, playerfront0], timePerFrame: 0.2)
        run(animation)
    }
    
}
