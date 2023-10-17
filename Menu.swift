//
//  Menu.swift
//  Underwoods
//
//  Created by Valerie on 16.10.23.
//

import Foundation
import SpriteKit
import GameplayKit

class Menu: SKScene {
    
    private var magicStick : SKEmitterNode?
    var endTouch = CGPoint()
    let backgroundImage = SKSpriteNode(imageNamed: "bgMenuReal")
    
    var priceCoins: SKLabelNode!
    var priceZero: SKLabelNode!
    
    let naviCrystal = SKSpriteNode(imageNamed: "obCrystal2")
    var playerCrystals = Int()
    var crystalLabel: SKLabelNode!
    let keyCrystals = "keyCrystals"
    var playerLevel = 0
    let keyLevel = "keyLevel"
    
    var bone = Bone()
    let keyBones = "keyBones"
    var playerBones = Int()
    let arrayBones = ["obBone0", "obBone1", "obBone2", "obBone3", "obBone4", "obBone5"]
    let arrayBonesgrey = ["bone0grey", "bone1grey", "bone2grey", "bone3grey", "bone4grey", "bone5grey"]
    
    var bone0 = SKSpriteNode()
    var bone1 = SKSpriteNode()
    var bone2 = SKSpriteNode()
    var bone3 = SKSpriteNode()
    var bone4 = SKSpriteNode()
    var bone5 = SKSpriteNode()
    
    let buttonLevel1 = SKSpriteNode(imageNamed: "playbutton-off.png")
    let buttonLevel1on = SKSpriteNode(imageNamed: "playbutton-on.png")
    
    override func didMove(to view: SKView) {
        self.magicStick = SKEmitterNode(fileNamed: "MyParticle.sks")
        if let magicStick = self.magicStick {
            magicStick.particleTexture = SKTexture(imageNamed: "magicstick.png")
            magicStick.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
                }

        let userDefaults = UserDefaults.standard
        playerCrystals = userDefaults.integer(forKey: keyCrystals)
        playerLevel = userDefaults.integer(forKey: keyLevel)
        playerBones = userDefaults.integer(forKey: keyBones)
        userDefaults.synchronize()

        backgroundImage.name = "Play"
        backgroundImage.position = CGPointMake(self.frame.midX, self.frame.midY)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.zPosition = -1
        addChild(backgroundImage)
        
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
        
        priceCoins = SKLabelNode(fontNamed: "Chalkduster")
        priceCoins.position = CGPoint(x: self.frame.maxX - 350, y: self.frame.maxY - 150)
        priceCoins.fontSize = 80
        priceCoins.fontColor = .black
        priceCoins.zPosition = 15
        priceCoins.alpha = 0.0
        addChild(priceCoins)
        priceCoins.text = " - 100 $"
        
        priceZero = SKLabelNode(fontNamed: "Chalkduster")
        priceZero.position = CGPoint(x: self.frame.maxX - 350, y: self.frame.maxY - 150)
        priceZero.fontSize = 80
        priceZero.fontColor = .black
        priceZero.zPosition = 15
        priceZero.alpha = 0.0
        addChild(priceZero)
        priceZero.text = "?? 100 $ ??"
        
        bone0 = SKSpriteNode(imageNamed: arrayBones[0])
        bone0.position = CGPoint(x: self.frame.midX - 1000, y: self.frame.minY + 800)
        bone0.setScale(0.9)
        bone0.zPosition = 10
        bone0.alpha = 0.0
        addChild(bone0)
        bone1 = SKSpriteNode(imageNamed: arrayBones[1])
        bone1.position = CGPoint(x: self.frame.midX - 600, y: self.frame.minY + 800)
        bone1.setScale(0.9)
        bone1.zPosition = 10
        bone1.alpha = 0.0
        addChild(bone1)
        bone2 = SKSpriteNode(imageNamed: arrayBones[4])
        bone2.position = CGPoint(x: self.frame.midX - 200, y: self.frame.minY + 800)
        bone2.setScale(0.9)
        bone2.zPosition = 10
        bone2.alpha = 0.0
        addChild(bone2)
        bone3 = SKSpriteNode(imageNamed: arrayBones[5])
        bone3.position = CGPoint(x: self.frame.midX + 200, y: self.frame.minY + 800)
        bone3.setScale(0.8)
        bone3.zPosition = 10
        bone3.alpha = 0.0
        addChild(bone3)
        bone4 = SKSpriteNode(imageNamed: arrayBones[2])
        bone4.position = CGPoint(x: self.frame.midX + 600, y: self.frame.minY + 800)
        bone4.setScale(0.8)
        bone4.zPosition = 10
        bone4.alpha = 0.0
        addChild(bone4)
        bone5 = SKSpriteNode(imageNamed: arrayBones[3])
        bone5.position = CGPoint(x: self.frame.midX + 1000, y: self.frame.minY + 800)
        bone5.setScale(0.9)
        bone5.zPosition = 10
        bone5.alpha = 0.0
        addChild(bone5)
        
        let bone0grey = SKSpriteNode(imageNamed: arrayBonesgrey[0])
        bone0grey.name = "buttonBone0"
        bone0grey.position = CGPoint(x: self.frame.midX - 1000, y: self.frame.minY + 800)
        bone0grey.setScale(0.9)
        bone0grey.zPosition = 5
        addChild(bone0grey)
        let bone1grey = SKSpriteNode(imageNamed: arrayBonesgrey[1])
        bone1grey.name = "buttonBone1"
        bone1grey.position = CGPoint(x: self.frame.midX - 600, y: self.frame.minY + 800)
        bone1grey.setScale(0.9)
        bone1grey.zPosition = 5
        addChild(bone1grey)
        let bone2grey = SKSpriteNode(imageNamed: arrayBonesgrey[4])
        bone2grey.name = "buttonBone2"
        bone2grey.position = CGPoint(x: self.frame.midX - 200, y: self.frame.minY + 800)
        bone2grey.setScale(0.9)
        bone2grey.zPosition = 5
        addChild(bone2grey)
        let bone3grey = SKSpriteNode(imageNamed: arrayBonesgrey[5])
        bone3grey.name = "buttonBone3"
        bone3grey.position = CGPoint(x: self.frame.midX + 200, y: self.frame.minY + 800)
        bone3grey.setScale(0.8)
        bone3grey.zPosition = 5
        addChild(bone3grey)
        let bone4grey = SKSpriteNode(imageNamed: arrayBonesgrey[2])
        bone4grey.name = "buttonBone4"
        bone4grey.position = CGPoint(x: self.frame.midX + 600, y: self.frame.minY + 800)
        bone4grey.setScale(0.8)
        bone4grey.zPosition = 5
        addChild(bone4grey)
        let bone5grey = SKSpriteNode(imageNamed: arrayBonesgrey[3])
        bone5grey.name = "buttonBone5"
        bone5grey.position = CGPoint(x: self.frame.midX + 1000, y: self.frame.minY + 800)
        bone5grey.setScale(0.9)
        bone5grey.zPosition = 5
        addChild(bone5grey)
        /*
        let buttonLevel0 = SKShapeNode(rectOf: CGSize(width: 400, height: 400))
        buttonLevel0.position = CGPoint(x: self.frame.midX - 600, y: self.frame.minY + 400)
        buttonLevel0.strokeColor = .init(white: 1.0, alpha: 0.5)
        buttonLevel0.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonLevel0.name = "buttonLevel0"
        buttonLevel0.zPosition = 6
        self.addChild(buttonLevel0)
        */
        
        buttonLevel1.position = CGPoint(x: self.frame.midX, y: self.frame.minY + self.size.height/4)
        buttonLevel1.name = "buttonLevel1"
        buttonLevel1.setScale(1.6)
        buttonLevel1.zPosition = 6
        self.addChild(buttonLevel1)
        
        buttonLevel1on.position = CGPoint(x: self.frame.midX, y: self.frame.minY + self.size.height/4)
        buttonLevel1on.name = "buttonLevel1"
        buttonLevel1on.setScale(1.6)
        buttonLevel1on.zPosition = 6
        buttonLevel1on.alpha = 0.0
        self.addChild(buttonLevel1on)
        /*
        let buttonLevel2 = SKShapeNode(rectOf: CGSize(width: 400, height: 400))
        buttonLevel2.position = CGPoint(x: self.frame.midX + 600, y: self.frame.minY + 400)
        buttonLevel2.strokeColor = .init(white: 1.0, alpha: 0.5)
        buttonLevel2.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonLevel2.name = "buttonLevel2"
        buttonLevel2.zPosition = 6
        self.addChild(buttonLevel2)
        */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            /*
            if nodeTouched.name == "buttonLevel0" {
                run("sound-button")
                playerLevel = 0
                let defaults = UserDefaults.standard
                defaults.set(0, forKey: keyLevel)
                self.view?.presentScene(PlayScene(size: self.size),
                               transition: .crossFade(withDuration: 2))
            }*/
            if nodeTouched.name == "buttonLevel1" {
                run("sound-button")
                playerLevel = 1
                buttonLevel1on.alpha = 1.0
                let defaults = UserDefaults.standard
                defaults.set(1, forKey: keyLevel)
                self.view?.presentScene(PlayScene(size: self.size),
                               transition: .crossFade(withDuration: 2))
            }
            
            if nodeTouched.name == "buttonBone0" {
                //if playerBones == 5 { return }
                if bone0.alpha == 1.0 { return }
                
/*preis*/       if playerCrystals <= 100 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.run(seq)
                    run("sound-bomb")
                    return}
                
                bone0.alpha = 1.0
                playerBones += 1
/*preis*/       playerCrystals -= 100
                run("sound-Coin")
                priceCoins.position = nodeTouched.position
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                run("sound-button")
            }

            if nodeTouched.name == "buttonBone1" {
               // if playerBones == 5 { return }
                if bone1.alpha == 1.0 { return }
                
/*preis*/       if playerCrystals <= 100 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.run(seq)
                    run("sound-bomb")
                    return }
                
                bone1.alpha = 1.0
                playerBones += 1
/*preis*/       playerCrystals -= 100
                run("sound-Coin")
                priceCoins.position = nodeTouched.position
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                run("sound-button")
            }
            
            if nodeTouched.name == "buttonBone2" {
                //if playerBones == 5 { return }
                if bone2.alpha == 1.0 { return }
                
/*preis*/       if playerCrystals <= 100 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.run(seq)
                    run("sound-bomb")
                    return}
                
                bone2.alpha = 1.0
                playerBones += 1
/*preis*/       playerCrystals -= 100
                run("sound-Coin")
                priceCoins.position = nodeTouched.position
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                run("sound-button")
            }
            
            if nodeTouched.name == "buttonBone3" {
                //if playerBones == 5 { return }
                if bone3.alpha == 1.0 { return }
                
/*preis*/       if playerCrystals <= 100 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.run(seq)
                    run("sound-bomb")
                    return }
                
                bone3.alpha = 1.0
                playerBones += 1
/*preis*/       playerCrystals -= 100
                run("sound-Coin")
                priceCoins.position = nodeTouched.position
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                run("sound-button")
            }
            
            if nodeTouched.name == "buttonBone4" {
               // if playerBones == 5 { return }
                if bone4.alpha == 1.0 { return }
                
/*preis*/       if playerCrystals <= 100 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.run(seq)
                    run("sound-bomb")
                    return }
                
                bone4.alpha = 1.0
                playerBones += 1
/*preis*/       playerCrystals -= 100
                run("sound-Coin")
                priceCoins.position = nodeTouched.position
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                run("sound-button")
            }
            
            if nodeTouched.name == "buttonBone5" {
                //if playerBones == 5 { return }
                if bone5.alpha == 1.0 { return }
                
/*preis*/       if playerCrystals <= 100 {
                    let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                    let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                    let seq = SKAction.sequence([fadein, fadeout])
                    priceZero.run(seq)
                    run("sound-bomb")
                    return }
                
                bone5.alpha = 1.0
                playerBones += 1
/*preis*/       playerCrystals -= 100
                run("sound-Coin")
                priceCoins.position = nodeTouched.position
                let fadein = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
                let fadeout = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
                let seq = SKAction.sequence([fadein, fadeout])
                priceCoins.run(seq)
                run("sound-button")
            }
           
            if let n = self.magicStick?.copy() as! SKEmitterNode? {
                n.position = location
                self.addChild(n)
            }
           }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch: AnyObject in touches {
                        endTouch = touch.location(in:self)
                    }
                guard var touch = touches.first else {return}
                touch = (touches.first as UITouch?)!
                let location = touch.location(in:self)
                if let n = self.magicStick?.copy() as! SKEmitterNode? {
                    n.position = location
                    self.addChild(n)
                }
        }
    
    override func update(_ currentTime: TimeInterval) {
        crystalLabel.text = "\(playerCrystals)"

        let defaults = UserDefaults.standard
        defaults.set(playerCrystals, forKey: keyCrystals)
        defaults.set(playerLevel, forKey: keyLevel)
        defaults.set(playerBones, forKey: keyBones)
        
        bone.checkForBones()
    }


    func run(_ fileName: String){
            run(SKAction.playSoundFileNamed(fileName, waitForCompletion: true))
    }
}
