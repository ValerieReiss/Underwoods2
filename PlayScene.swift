//
//  Menu.swift
//  Shooter
//
//  Created by Valerie on 02.03.23.
//

import Foundation
import SpriteKit
import GameplayKit
import simd

class PlayScene: SKScene, SKPhysicsContactDelegate {

    var crystalLabel: SKLabelNode!
    var boneLabel: SKLabelNode!
    var endLabel: SKLabelNode!
    let naviCrystal = SKSpriteNode(imageNamed: "obCrystal2")
    var playerCrystals = Int()
    let keyCrystals = "keyCrystals"
    
    let naviBone = SKSpriteNode(imageNamed: "obBone0")
    var playerBones = 0
    
    var playerLevel = 0
    let keyLevel = "keyLevel"
    
    private var magicStick : SKEmitterNode?
    
    var player = Player()
    
    var lastUpdateTime:TimeInterval = 0
    var dt:TimeInterval = 0
    var playableRectArea:CGRect = CGRectZero
    var currentTouchPosition: CGPoint  = CGPointZero
    
    //var currentPlayerPosition: CGPoint = CGPointZero
    var normalPlayerPositionX = 1200
    var normalPlayerPositionY = 400
    
    var background = Background(type: 0)
    var endBackgroundPosition = CGFloat()
    
    var leftButtonIsPressed = false
    var rightButtonIsPressed = false
    var zahl = 0
    
    var bone = Bone()
    let arrayBones = ["obBone0", "obBone1", "obBone2", "obBone3", "obBone4", "obBone5"]
    var randomBone = Int()
    
    var crystal = Crystal()
    var randomCrystal = Int()
    let arrayCrystals = ["obCrystal0", "obCrystal1", "obCrystal2", "obCrystal3", "obCrystal4", "obCrystal5", "obCrystal6", "obCrystal7"]
    
    
    override func didMove(to view: SKView) {
      
        physicsWorld.contactDelegate = self
        scene?.physicsWorld.gravity = CGVectorMake(0,0)
        
        self.magicStick = SKEmitterNode(fileNamed: "MyParticle.sks")
        if let magicStick = self.magicStick {
            magicStick.particleTexture = SKTexture(imageNamed: "magicstick.png")
            magicStick.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
        }
        
        
        let userDefaults = UserDefaults.standard
        playerCrystals = userDefaults.integer(forKey: keyCrystals)
        playerLevel = userDefaults.integer(forKey: keyLevel)
        userDefaults.synchronize()
        
        background.position = CGPointMake(self.frame.minX+17165, self.frame.midY) //19560
        background.size = CGSize(width: 34330, height: self.size.height)
        addChild(background)
        background.move()
        endBackgroundPosition = 17165 //31500    //CGFloat(-17165.0 + self.frame.width)
     
        player.position = CGPoint(x: self.frame.midX - 200, y: self.frame.minY + 400)
        self.addChild(player)
        player.moveRight()
        _ = Timer.scheduledTimer(withTimeInterval: 8.2, repeats: true) { timer2 in
            self.player.wave()
        }
        
        /*_ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer2 in
            self.player.moveRight()
            self.background.move()
        }*/
        
        
        _ = Timer.scheduledTimer(withTimeInterval: 13.0, repeats: true) { timer2 in
            self.bone.position = CGPoint(x: 2000, y: Int.random(in: 200..<250))
            self.randomBone = Int.random(in: 0..<6)
            self.addChild(self.bone)
            self.bone.move()
        }
        _ = Timer.scheduledTimer(withTimeInterval: 9.0, repeats: true) { timer2 in
            self.crystal.position = CGPoint(x: 2000, y: Int.random(in: 850..<950))
            self.randomCrystal = Int.random(in: 0..<8)
            self.addChild(self.crystal)
            self.crystal.move()
        }
        
        let jump = SKShapeNode(circleOfRadius: 100)
        jump.name = "jump"
        jump.zPosition = 6
        jump.position = CGPoint(x: self.frame.midX+1050, y: self.frame.midY-280)
        //jump.position = CGPoint(x: self.frame.midX-1050, y: self.frame.midY-280)
        jump.strokeColor = .init(white: 1.0, alpha: 1.0)
        jump.setScale(2)
        self.addChild(jump)
                
        /*let rechts = SKShapeNode(circleOfRadius: 100)
        rechts.name = "rechts"
        rechts.zPosition = 6
        rechts.position = CGPoint(x: self.frame.midX+1050, y: self.frame.midY-280)
        rechts.strokeColor = .init(white: 1.0, alpha: 1.0)
        rechts.setScale(2)
        self.addChild(rechts)*/
        
        naviBone.position = CGPoint(x: self.frame.maxX - 200, y: self.frame.maxY - 100)
        naviBone.setScale(0.6)
        naviBone.isUserInteractionEnabled = false
        self.addChild(naviBone)
        boneLabel = SKLabelNode(fontNamed: "Chalkduster")
        boneLabel.position = CGPoint(x: self.frame.maxX - 350, y: self.frame.maxY - 150)
        boneLabel.fontSize = 80
        boneLabel.fontColor = .black
        boneLabel.zPosition = 2
        addChild(boneLabel)
        boneLabel.text = "\(playerBones)"
        
        naviCrystal.position = CGPoint(x: self.frame.maxX - 200, y: self.frame.maxY - 250)
        naviCrystal.setScale(0.4)
        naviCrystal.zPosition = 2
        addChild(naviCrystal)
        crystalLabel = SKLabelNode(fontNamed: "Chalkduster")
        crystalLabel.position = CGPoint(x: self.frame.maxX - 350, y: self.frame.maxY - 300)
        crystalLabel.fontSize = 80
        crystalLabel.fontColor = .black
        crystalLabel.zPosition = 2
        addChild(crystalLabel)
        crystalLabel.text = "\(playerCrystals)"
        
        if background.endstation() == true {
            end()
        }
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            currentTouchPosition = touch.location(in: self)
            let nodeTouched = atPoint(currentTouchPosition)
            
            if nodeTouched.name == "Menu" {
                        self.view?.presentScene(GameScene(size: self.size),
                       transition: .crossFade(withDuration: 2))
                        run("sound-button")
            }
            
            if (nodeTouched.name == "jump") {
                if(player.position.y >= 420) {
                    player.jump()
                    let blub = SKAction.move(to: CGPoint(x: normalPlayerPositionX, y: normalPlayerPositionY), duration: 0.05)
                    player.run(blub)
                }
                else
                {
                    player.jump()
                    let bla = SKAction.moveTo(y: player.position.y+300, duration: 0.3)
                    bla.timingFunction = {time in return simd_smoothstep(0, 1, time)}
                    let blub = SKAction.move(to: CGPoint(x: normalPlayerPositionX, y: normalPlayerPositionY), duration: 0.1)
                    blub.timingFunction = {time in return simd_smoothstep(0, 1, time)}
                    let sequence = SKAction.sequence([bla, blub])
                    player.run(sequence)
                    
                }
            }
            
            if (nodeTouched.name == "rechts") {
                zahl = 1
                player.runRight()
                background.run()

            }
            
            if let n = self.magicStick?.copy() as! SKEmitterNode? {
                n.position = currentTouchPosition
                self.addChild(n)
            }
        }
    }
     
    func didBegin(_ contact: SKPhysicsContact){
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if (contactMask == 3) // player - bone
        {print ("....................................................bone")
            run("sound-button")
            playerBones += 1
            if contact.bodyA.node?.name == "bone" {
                if let sparkleStars = SKEmitterNode(fileNamed: "particle-stars"){
                    sparkleStars.particleTexture = SKTexture(imageNamed: "obBone0")
                    sparkleStars.position = player.position
                    sparkleStars.zPosition = 10
                    addChild(sparkleStars)}
                contact.bodyA.node?.removeFromParent()
            } else { contact.bodyB.node?.removeFromParent() }
            
        }
        else if (contactMask == 5) // player - crystal
        {print ("..................................................crystal")
            run("sound-Coin")
            playerCrystals += 1
            if contact.bodyA.node?.name == "crystal" {
                if let sparkleStars = SKEmitterNode(fileNamed: "particle-stars"){
                    sparkleStars.particleTexture = SKTexture(imageNamed: "obBone0")
                    sparkleStars.position = player.position
                    sparkleStars.zPosition = 10
                    addChild(sparkleStars)}
                contact.bodyA.node?.removeFromParent()
            }
        }
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        let defaults = UserDefaults.standard
        defaults.set(playerCrystals, forKey: keyCrystals)
        defaults.set(playerLevel, forKey: keyLevel)
        
        
            crystalLabel.text = "\(playerCrystals)"
            boneLabel.text = "\(playerBones)"
            if lastUpdateTime > 0 {dt = currentTime - lastUpdateTime}
            else {dt = 0}
            lastUpdateTime = currentTime
        
        if background.endstation() == true {
            end()
        }
        
    }
    

    func end(){
        
        player.stopMoving()
        player.won()
        endLabel = SKLabelNode(fontNamed: "Chalkduster")
        endLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 200)
        endLabel.fontSize = 160
        endLabel.fontColor = .black
        endLabel.zPosition = 2
        addChild(endLabel)
        endLabel.text = "Well Done!"
        
        naviBone.position = CGPoint(x: self.frame.midX + 600, y: self.frame.midY)
        boneLabel.position = CGPoint(x: self.frame.midX + 350, y: self.frame.midY - 60)
        
        naviCrystal.position = CGPoint(x: self.frame.midX + 600, y: self.frame.midY - 170)
        crystalLabel.position = CGPoint(x: self.frame.midX + 350, y: self.frame.midY - 210)
        
        
        if playerCrystals > playerBones {
            if let crystalregen = SKEmitterNode(fileNamed: "particle-geldregen"){
                crystalregen.position = CGPoint(x: self.frame.maxX - 400, y: self.frame.maxY + 300)
                addChild(crystalregen)
            }
            if let crystalregen2 = SKEmitterNode(fileNamed: "particle-geldregen"){
                crystalregen2.position = CGPoint(x: self.frame.minX + 400, y: self.frame.maxY + 300)
                addChild(crystalregen2)
            }
            _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer2 in
                self.player.won()
            }
            run("sound-won")
        }
        if playerBones > playerCrystals {
            if let boneregen = SKEmitterNode(fileNamed: "particle-geldregen"){
                    boneregen.particleTexture = SKTexture(imageNamed: "obBone2")
                    boneregen.position = CGPoint(x: self.frame.maxX - 400, y: self.frame.maxY + 300)
                    addChild(boneregen)
            }
            if let boneregen2 = SKEmitterNode(fileNamed: "particle-geldregen"){
                    boneregen2.particleTexture = SKTexture(imageNamed: "obBone4")
                    boneregen2.position = CGPoint(x: self.frame.minX + 400, y: self.frame.maxY + 300)
                    addChild(boneregen2)
            }
            _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer2 in
                self.player.won() //self.player.wave()
            }
            run("sound-won")
        }
        if playerBones == 0 && playerCrystals == 0 {
            endLabel.alpha = 0.0
        }
        
    }
    
    func run(_ fileName: String){
            run(SKAction.playSoundFileNamed(fileName, waitForCompletion: true))
        
    }
    
}
