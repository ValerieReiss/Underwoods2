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
    
    let naviCrystal = SKSpriteNode(imageNamed: "obCrystal2")
    var playerCrystals = Int()
    var crystalLabel: SKLabelNode!
    let keyCrystals = "keyCrystals"
    var playerLevel = 0
    let keyLevel = "keyLevel"
    
    let arrayBones = ["obBone0", "obBone1", "obBone2", "obBone3", "obBone4", "obBone5"]
    
    override func didMove(to view: SKView) {
        self.magicStick = SKEmitterNode(fileNamed: "MyParticle.sks")
        if let magicStick = self.magicStick {
            magicStick.particleTexture = SKTexture(imageNamed: "magicstick.png")
            magicStick.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
                }

        let userDefaults = UserDefaults.standard
        playerCrystals = userDefaults.integer(forKey: keyCrystals)
        playerLevel = userDefaults.integer(forKey: keyLevel)
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
        
        let bone0 = SKSpriteNode(imageNamed: arrayBones[0])
        bone0.position = CGPoint(x: self.frame.midX - 1000, y: self.frame.minY + 800)
        addChild(bone0)
        
        let bone1 = SKSpriteNode(imageNamed: arrayBones[1])
        bone1.position = CGPoint(x: self.frame.midX - 600, y: self.frame.minY + 800)
        addChild(bone1)
        
        let bone2 = SKSpriteNode(imageNamed: arrayBones[2])
        bone2.position = CGPoint(x: self.frame.midX - 200, y: self.frame.minY + 800)
        addChild(bone2)
        
        let bone3 = SKSpriteNode(imageNamed: arrayBones[3])
        bone3.position = CGPoint(x: self.frame.midX + 200, y: self.frame.minY + 800)
        addChild(bone3)
        
        let bone4 = SKSpriteNode(imageNamed: arrayBones[4])
        bone4.position = CGPoint(x: self.frame.midX + 600, y: self.frame.minY + 800)
        addChild(bone4)
        
        let bone5 = SKSpriteNode(imageNamed: arrayBones[5])
        bone5.position = CGPoint(x: self.frame.midX + 1000, y: self.frame.minY + 800)
        addChild(bone5)
        
        let buttonLevel0 = SKShapeNode(rectOf: CGSize(width: 400, height: 400))
        buttonLevel0.position = CGPoint(x: self.frame.midX - 600, y: self.frame.minY + 400)
        buttonLevel0.strokeColor = .init(white: 1.0, alpha: 0.5)
        buttonLevel0.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonLevel0.name = "buttonLevel0"
        buttonLevel0.zPosition = 6
        self.addChild(buttonLevel0)
        
        let buttonLevel1 = SKShapeNode(rectOf: CGSize(width: 400, height: 400))
        buttonLevel1.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 400)
        buttonLevel1.strokeColor = .init(white: 1.0, alpha: 0.5)
        buttonLevel1.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonLevel1.name = "buttonLevel1"
        buttonLevel1.zPosition = 6
        self.addChild(buttonLevel1)
        
        let buttonLevel2 = SKShapeNode(rectOf: CGSize(width: 400, height: 400))
        buttonLevel2.position = CGPoint(x: self.frame.midX + 600, y: self.frame.minY + 400)
        buttonLevel2.strokeColor = .init(white: 1.0, alpha: 0.5)
        buttonLevel2.fillColor = .init(white: 1.0, alpha: 0.3)
        buttonLevel2.name = "buttonLevel2"
        buttonLevel2.zPosition = 6
        self.addChild(buttonLevel2)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            
            if nodeTouched.name == "buttonLevel0" {
                run("sound-button")
                playerLevel = 0
                let defaults = UserDefaults.standard
                defaults.set(0, forKey: keyLevel)
                self.view?.presentScene(PlayScene(size: self.size),
                               transition: .crossFade(withDuration: 2))
            }
            if nodeTouched.name == "buttonLevel1" {
                run("sound-button")
                playerLevel = 1
                let defaults = UserDefaults.standard
                defaults.set(1, forKey: keyLevel)
                self.view?.presentScene(PlayScene(size: self.size),
                               transition: .crossFade(withDuration: 2))
            }
            if nodeTouched.name == "buttonLevel2" {
                run("sound-button")
                playerLevel = 2
                let defaults = UserDefaults.standard
                defaults.set(2, forKey: keyLevel)
                self.view?.presentScene(PlayScene(size: self.size),
                               transition: .crossFade(withDuration: 2))
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
        
    }


    func run(_ fileName: String){
            run(SKAction.playSoundFileNamed(fileName, waitForCompletion: true))
    }
}
