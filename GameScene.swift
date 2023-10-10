//
//  GameScene.swift
//  Underwood
//
//  Created by Valerie on 16.07.23.
//
import Foundation
import SpriteKit

class GameScene: SKScene {
    
    private var magicStick : SKEmitterNode?
    var endTouch = CGPoint()
    let backgroundImage = SKSpriteNode(imageNamed: "bgMenu")
    
    override func didMove(to view: SKView) {
        self.magicStick = SKEmitterNode(fileNamed: "MyParticle.sks")
        if let magicStick = self.magicStick {
            magicStick.particleTexture = SKTexture(imageNamed: "magicstick.png")
            magicStick.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
                }
        backgroundImage.name = "Play"
        backgroundImage.position = CGPointMake(self.frame.midX, self.frame.midY)
        backgroundImage.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundImage.zPosition = -1
        addChild(backgroundImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            
            if nodeTouched.name == "Play" {
                print ("passt")
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
    
    func run(_ fileName: String){
            run(SKAction.playSoundFileNamed(fileName, waitForCompletion: true))
    }
}
