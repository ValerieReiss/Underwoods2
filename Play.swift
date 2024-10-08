
import SpriteKit
class Play: SKScene {
    weak var vC: GameViewController!
    
    var backgroundImage = SKSpriteNode(imageNamed: "bgMoving")
    var endBackgroundPosition = CGFloat()
    var currentTouchPosition: CGPoint  = CGPointZero
    var backgroundSpeed:CGFloat=2
    
    let person=SKSpriteNode(imageNamed: "1")
    var runningSpeed=0.1
    var jumpSpeed:CGFloat=0
    var blockSpeed:CGFloat = 2
    var birdSpeed:CGFloat=2.5
    
    let block=SKSpriteNode.init(color: UIColor.black, size: CGSize(width: 100, height: 100))
    var boneCatched=false
    let bone0=SKTexture.init(imageNamed: "bone0")
    let bone1=SKTexture.init(imageNamed: "bone1")
    let bone2=SKTexture.init(imageNamed: "bone2")
    let bone3=SKTexture.init(imageNamed: "bone3")
    let bone4=SKTexture.init(imageNamed: "bone4")
    let bone5=SKTexture.init(imageNamed: "bone5")
    
    let crystal=SKSpriteNode.init(color: UIColor.black, size: CGSize(width: 100, height: 100))
    let crystal1=SKTexture.init(imageNamed:"obCrystal1")
    let crystal2=SKTexture.init(imageNamed:"obCrystal2")
    let crystal3=SKTexture.init(imageNamed:"obCrystal3")
    let crystal4=SKTexture.init(imageNamed:"obCrystal4")
    let crystal5=SKTexture.init(imageNamed:"obCrystal5")
    let crystal6=SKTexture.init(imageNamed:"obCrystal6")
    let crystal7=SKTexture.init(imageNamed:"obCrystal7")
//    var crystalCatched=false
    
    let laserGun=SKSpriteNode.init(color: UIColor.black, size: CGSize(width: 100, height: 100))
    let laserGun1=SKTexture.init(imageNamed: "bone2")
    var laserCatched=false
    var laserShots:Int = 3
    
    let bird=SKSpriteNode(imageNamed: "obCrystal0")
    let explosion=SKSpriteNode(imageNamed: "explosion1")
    let heart=SKSpriteNode(imageNamed: "heart")
    let laserShot=SKSpriteNode.init(color: UIColor.red, size: CGSize(width: 100, height: 5))
    
    let smallHeart=SKSpriteNode(imageNamed:"heartMark")
    let smallHeart2=SKSpriteNode(imageNamed:"heartMark")
    let smallHeart3=SKSpriteNode(imageNamed:"heartMark")
    //create 3 small hearts representing the lifes
    let smallCryst=SKSpriteNode(imageNamed:"obCrystal2")
    
    var randomTime:CGFloat=0
    var randomTime2:CGFloat=0
    
    var speedIndex:CGFloat=0.98     //create speed Index for speed increasing
    var collided=false               //create a bool for determining collission
    var lifes=1                    //create and intial life of 1
    
    var fail=false               //create and initial not fail game
    var mark=0                  //create a int variable recording mark
    let transparency=SKTexture.init(imageNamed: "transparent")           //create a transparent background for hidden image
    let heartPic=SKTexture.init(imageNamed: "heartMark")                 //create heart for adding life
    //let crystPic=SKTexture.init(imageNamed: "obCrystal2")
    let marklbl = SKLabelNode(fontNamed: "Chalkduster")                     //create the label for displaying the mark
    let markPluslbl = SKLabelNode(fontNamed: "Chalkduster")                  //create the label for displaying the mark
    
    let birdSound=SKAction.playSoundFileNamed("birdExplode.mp3", waitForCompletion: true)
    let laserGunLoadedSound=SKAction.playSoundFileNamed("laserGunSound.mp3", waitForCompletion: true)
    let lifeGotSound=SKAction.playSoundFileNamed("lifeSound.mp3", waitForCompletion: true)
    let backGrMusic=SKAudioNode(fileNamed:"forest1.mp3")
    let shooting=SKAudioNode(fileNamed:"shotSound.mp3")
    
    func reLocateBlock() -> Void{
        let boneArray=[bone0,bone1,bone2,bone3,bone4,bone5]
        let index=Int(arc4random_uniform(UInt32(6)))
        block.texture=boneArray[index]
        randomTime=CGFloat((arc4random_uniform(500)))+500
        block.size = CGSize(width: self.size.width/9, height: self.size.height/7)
        block.position.x=size.width+block.size.width/2+randomTime
        block.position.y=frame.height/2 - 80
    }
   
    func relocateCrystal() -> Void{
        let crystalArray=[crystal1,crystal2,crystal3,crystal4,crystal5,crystal6,crystal7]
        let index=Int(arc4random_uniform(UInt32(7)))
        crystal.texture=crystalArray[index]
        
        var randomY:CGFloat=0.0
        randomY=CGFloat((arc4random_uniform(UInt32(0.3*size.height))))+0.5*size.height  //randomHeight=30
        randomTime=CGFloat((arc4random_uniform(1000)))+1000
        crystal.position.x=size.width+bird.size.width/2+randomTime //gun must be out of the screen
        crystal.position.y=randomY
        if picTooClose(object1: crystal, object2: heart)||picTooClose(object1: crystal, object2: bird){
            relocateCrystal() //run the function again if the objects are too close
        }
    }
    
    func markPlus(score:Int) -> Void{
        markPluslbl.position = CGPoint(x: frame.midX+2*marklbl.frame.size.width, y: frame.size.height-30)
        markPluslbl.text="+"+String(score)
        //display proper +1 or +5
        let fadedin=SKAction.sequence([SKAction.fadeOut(withDuration: 0.5),SKAction.fadeIn(withDuration: 0)])
        //fade in to disappear
        markPluslbl.run(fadedin, withKey: "disappear")
        //run animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
            self.markPluslbl.position.y+=30+self.markPluslbl.frame.height
            //when it disappeared, 0.4 sec later, relocate it so it's not visible
        }
    }
    //when the game ends.
    func ifFail(){
        
        let front = SKTexture.init(imageNamed: "player-front0")
        person.texture=front
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            self.person.run(SKAction.repeatForever(self.WaveAction(x:self.runningSpeed)), withKey: "waving") //start waving
        }
        //Timer(timeInterval: 4.0, repeats: true, block: WaveAction(x: runningSpeed) -> Void)
       /* _ = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { timer2 in
            self.WaveAction(x: self.runningSpeed)
        }*/
        
        let result = SKLabelNode(fontNamed: "Chalkduster")
        result.text = "Game Over!"
        result.fontSize = 50
        result.fontColor = SKColor.black
        result.position = CGPoint(x: frame.midX, y: frame.midY)                  //define the result label
        let fadein=SKAction.sequence([SKAction.fadeOut(withDuration: 0),SKAction.fadeIn(withDuration: 2)])       //create the fade in animation
        addChild(result)
        result.run(fadein)              //display the result label
        
        vC.endMark=mark
        //transfer the mark
    }
    func LaserAppear() -> Void{
        let jump0 = SKTexture.init(imageNamed: "player-jump-bone0")
        let jump1 = SKTexture.init(imageNamed: "player-jump-bone1")
        let jump3 = SKAction.moveTo(y: frame.height/2 + 40, duration: 0.4)
        //let jump4 = SKAction.move(to: CGPoint(x:0.5*person.frame.width + 100, y:frame.height/2 + 20), duration: 0.05)
        //let sequence = SKAction.sequence([jump3, jump4])
        person.run(jump3)
        let runningArray=[jump0,jump1,jump0,jump1,jump0,jump1]
        let runningAnimation = SKAction.animate(with: runningArray, timePerFrame: 0.1)
        person.run(runningAnimation)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){ [self] in
            self.person.run(SKAction.repeatForever(self.laserAction(x: runningSpeed)), withKey:"running")
            laserGun.alpha = 1.0
            laserShots = 3
            laserGun.position=CGPoint(x: person.position.x + 100, y:0)
            
            if laserShots <= 0 {
                LaserDisappear()
            }
            //play laser music when not end game
        }
    }
    func LaserDisappear() -> Void{
        person.run(SKAction.repeatForever(RunningAction(x: runningSpeed)), withKey:"running")
        laserGun.alpha = 0.0
        shooting.run(SKAction.stop())
        //stop music of laser
    }
    
    func relocateHeart() -> Void{
        var randomY:CGFloat=0.0
        randomY=CGFloat((arc4random_uniform(UInt32(0.3*size.height))))+0.5*size.height  //randomHeight=30
        randomTime=CGFloat((arc4random_uniform(3000)))+1000
        heart.position.x=size.width+bird.size.width/2+randomTime  //make sure the heart is out of the screen
        heart.position.y=randomY
        //use random number to locate the new coordinate of x,y
        if picTooClose(object1: heart, object2: bird)||picTooClose(object1: heart, object2: crystal){
            relocateHeart()
        }
    }
    func picTooClose(object1: SKSpriteNode, object2: SKSpriteNode) -> Bool{
        //make a function to check if 2 objects are too close to each other
        let xA=object1.position.x
        let xB=object2.position.x
        //get the x coordinate of 2 objects
        let difference=abs(xA-xB)  //find the distance between
        if difference<=200{
            //if closer than 200
            return true
        }
        return false
    }
    func reLocateBird() -> Void{
        var randomY:CGFloat=0.0
        randomY=CGFloat((arc4random_uniform(UInt32(0.3*size.height))))+0.5*size.height
        randomTime=CGFloat((arc4random_uniform(1000)))+1000
        bird.position.x=size.width+bird.size.width/2+randomTime   //make sure the bird is out of the screen
        bird.position.y=randomY
        if picTooClose(object1: bird, object2: crystal)||picTooClose(object1: bird, object2: heart){
            reLocateBird()
        }
    }
    func collideResult() ->  Void{
        let posture=person.texture!   //posture change to normal, no laser gun
        let transparency=SKTexture.init(imageNamed: "transparent")   //texture for completing blink
        person.removeAction(forKey: "running")
        jumpSpeed=0
        let failArray=[transparency,posture]
        let failAnimation=SKAction.animate(with: failArray, timePerFrame: 0.4)
        person.run(SKAction.repeat(failAnimation, count: 3)) //create and run blink animation
        
        guard !fail else{ //run only when not end game
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8){
            self.person.position.y=self.size.height+self.person.frame.height/2
            self.person.run(SKAction.moveTo(y: 0.5*self.person.frame.height, duration: 1.2))
            self.reLocateBird()
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.collided = false // no collision
            self.person.run(SKAction.repeatForever(self.RunningAction(x:self.runningSpeed)), withKey: "running") //start running
        }
    }
    func RunningAction(x:Double) -> SKAction {
        let run1 = SKTexture.init(imageNamed: "1")
        let run2 = SKTexture.init(imageNamed: "running2")
        let run3 = SKTexture.init(imageNamed: "running3")
        let run4 = SKTexture.init(imageNamed: "running4")
        let run5 = SKTexture.init(imageNamed: "running5")
        let run6 = SKTexture.init(imageNamed: "running6")
        let run7 = SKTexture.init(imageNamed: "running7")
        let run8 = SKTexture.init(imageNamed: "running8")
        let runningArray=[run1,run2,run3,run4,run5,run6,run7,run8]
        let runningAnimation = SKAction.animate(with: runningArray, timePerFrame: x)
        return runningAnimation
    }
    func WaveAction(x:Double) -> SKAction {
        let playerwave1 = SKTexture(imageNamed: "player-wave1")
        let playerwave2 = SKTexture(imageNamed: "player-wave2")
        let playerwave0 = SKTexture(imageNamed: "player-wave0")
        let playerfront0 = SKTexture(imageNamed: "player-front0")
        let waveArray=[playerwave0, playerwave1, playerwave2, playerwave1, playerwave0, playerfront0]
        let waveAnimation = SKAction.animate(with: waveArray, timePerFrame: x)
        return waveAnimation
    }
    func laserAction(x:Double) -> SKAction {
        let laser1 = SKTexture.init(imageNamed: "player-laser1")
        let laser2 = SKTexture.init(imageNamed: "player-laser2")
        let laser3 = SKTexture.init(imageNamed: "player-laser3")
        let laser4 = SKTexture.init(imageNamed: "player-laser4")
        let laser5 = SKTexture.init(imageNamed: "player-laser5")
        let laser6 = SKTexture.init(imageNamed: "player-laser6")
        let laser7 = SKTexture.init(imageNamed: "player-laser7")   //create 7 textures to store the animation for laser running
        let laserArray=[laser1,laser2,laser3,laser4,laser5,laser6,laser7]   //create an array representing the animation
        let laserAnimation=SKAction.animate(with: laserArray,
                                            timePerFrame: x)
        return laserAnimation
    }
    func BirdAction(x:Double) -> SKAction {
        let birdAnimation = SKAction.rotate(byAngle: 360, duration: 1.0)
        return birdAnimation
    }
    func explosionAction() -> SKAction {
        let boom1=SKTexture.init(imageNamed: "explosion1")
        let boom2=SKTexture.init(imageNamed: "explosion2")
        let boom3=SKTexture.init(imageNamed: "explosion3")
        let boom4=SKTexture.init(imageNamed: "explosion4")
        let boom5=SKTexture.init(imageNamed: "explosion5")
        let boom6=SKTexture.init(imageNamed: "explosion6")
        let boom7=SKTexture.init(imageNamed: "explosion7")
        let boom8=SKTexture.init(imageNamed: "explosion8")
        let boom9=SKTexture.init(imageNamed: "explosion9")
        let boom10=SKTexture.init(imageNamed: "explosion10")
        let boom11=SKTexture.init(imageNamed: "explosion11")
        let boom12=SKTexture.init(imageNamed: "explosion12")      //create 12 textures for the animation of boom
        let boomArray=[boom1,boom2,boom3,boom4,boom5,boom6,boom7,boom8,boom9,boom10,boom11,boom12]  //create an array representing the animation
        let boomAnimation=SKAction.animate(with: boomArray, timePerFrame: 0.06) //create an action of animation
        return boomAnimation
    }
    /*func jumpSuccess(posXman:CGFloat,posYman:CGFloat,posXbox:CGFloat,widthBox:CGFloat, heightBox:CGFloat) -> Bool? {
        let minX=posXbox-0.5*widthBox
        let maxX=posXbox+0.5*widthBox
        let checkPoint=posYman-48
        let collide=(posXman>minX)&&(posXman<maxX)                      //create the transparent background
        let smallHeartArray=[smallHeart,smallHeart2,smallHeart3]
        //create the array to manipulate the hearts
       if collide{
            if checkPoint < heightBox{ //if it really collides with block
                relocateLaserGun()
                relocateHeart()
                reLocateBird()   //relocate flying object
                LaserDisappear() //laser disappears
                lifes-=1   //decrease the life
                if lifes<=0{  //when no life
                    fail=true  //failed the game
                    ifFail() //run function for fail condition
                }
                else{
                    smallHeartArray[lifes].position.y=2*frame.size.height  //one heart disappears
                }
                return false
            }
        }else{
            return true
        }
        return true
    }*/
    func checkIfCrystal(object: SKSpriteNode) -> Bool {
        let HeightBottom=object.position.y-0.5*crystal.size.height   //find the value of the bottom of laser item
        let Left=object.position.x-0.5*crystal.size.width    //find the value of the left side of laser item
        let Right=object.position.x+0.5*crystal.size.width    //find the value of the right side of laser item
        let HeightTop=object.position.y+0.5*crystal.size.height   //find the value of the top of laser item
        let personTop=person.position.y+43     //find the value of the top of stickman
        let personBottom=person.position.y-48  //find the value of the bottom of stickman
        let personRight=person.position.x+47   //find the right side of the stickman
        let collide=personRight>Left&&Right>50    //see if x location meets
        let gun=(object==crystal)   //check if it is heart or gun
        if collide{
           /* //if their x loc meet
            if personBottom<HeightTop&&personBottom>HeightBottom{ //meets bottom
                if gun{ person.run(lifeGotSound)
                }else{ person.run(lifeGotSound) }
                return true
            } else if personTop>HeightBottom&&personTop<HeightTop{ // meets upon
                if gun{ person.run(lifeGotSound)
                }else{  person.run(lifeGotSound)}
                return true
            } else if personTop>HeightTop&&personBottom<HeightBottom{   //meet through middle
                if gun{ person.run(lifeGotSound)
                }else{  person.run(lifeGotSound)}
                return true
            }*/
            return true
        }
        return false
    }
    
    func checkIfLaser(object: SKSpriteNode) -> Bool {
        let HeightBottom=object.position.y-0.5*bird.size.height   //find the value of the bottom of laser item
        let Left=object.position.x-0.5*bird.size.width    //find the value of the left side of laser item
        let Right=object.position.x+0.5*bird.size.width    //find the value of the right side of laser item
        let HeightTop=object.position.y+0.5*bird.size.height   //find the value of the top of laser item
        let personTop=laserGun.position.y+43     //find the value of the top of stickman
        let personBottom=laserGun.position.y-48  //find the value of the bottom of stickman
        let personRight=laserGun.position.x+100   //find the right side of the stickman
        let collide=personRight>Left&&Right>50    //see if x location meets
        let bone=(object==laserGun)
        if collide {
//           // shooting.run(SKAction.play())
            /*//if their x loc meet
            if personBottom<HeightTop&&personBottom>HeightBottom {       //if it meets from foot
                if bone{ laserGun.run(laserGunLoadedSound)
                }else{ laserGun.run(lifeGotSound)}
                return true
            } else if personTop>HeightBottom&&personTop<HeightTop {      //meet from head
                if bone{ laserGun.run(laserGunLoadedSound)
                }else{ laserGun.run(lifeGotSound)}
                return true
            } else if personTop>HeightTop&&personBottom<HeightBottom {    //meet through middle
                if bone{ laserGun.run(laserGunLoadedSound)
                }else{ laserGun.run(lifeGotSound)}
                return true
            }*/
            return true
        }
        return false
    }
    func hitTheBird() -> Void{
        bird.removeAction(forKey: "bird")
        explosion.run(explosionAction())
        explosion.position=bird.position
        explosion.run(birdSound)
        reLocateBird()
        mark+=5
        markPlus(score: 5)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.72){
                    self.explosion.position=CGPoint(x:2*self.frame.size.width,y:self.person.position.y+15)   //explosion goes away
                }
    }
    
    override func didMove(to view: SKView) {
        backgroundImage.name = "bgMoving"
        backgroundImage.position = CGPointMake(self.frame.minX+7500, self.frame.midY)
        backgroundImage.size = CGSize(width: 15000, height: self.size.height) //34330
        backgroundImage.zPosition = -1
        addChild(backgroundImage)
        endBackgroundPosition = CGFloat(-17165.0 + self.frame.width)
        
        person.setScale(0.4)
        person.position=CGPoint(x:0.5*person.frame.width + 100, y:frame.height/2 + 20) //5.0*person.frame.height)
        person.run(SKAction.repeatForever(RunningAction(x: runningSpeed)), withKey:"running")
        addChild(person)
        
        reLocateBlock()
        block.position=CGPoint(x:0.5*size.width,y:0.5*block.frame.height)
        addChild(block)
        
        relocateCrystal()
        addChild(crystal)
        
        relocateHeart()
        reLocateBird()
        bird.setScale(0.5)
        bird.run(SKAction.repeatForever(BirdAction(x: 0.05)), withKey:"bird")
        addChild(bird)
        
        laserGun.alpha = 0.0
        //laserShot.setScale(1.0)
        let beam=SKTexture.init(imageNamed: "bone2")
        laserGun.texture=beam
        laserGun.size = CGSize(width: self.size.width/7, height: self.size.height/6)
        laserGun.position=CGPoint(x:person.position.x + 100, y: 0)
        addChild(laserGun)
        shooting.run(SKAction.stop())
        //don't have laser sound at start
        
        explosion.position=CGPoint(x:2*frame.size.width,y:person.position.y+15)
        addChild(explosion)
        addChild(heart)
        smallHeart.position=CGPoint(x:50, y:frame.size.height-50)
        smallHeart2.position=CGPoint(x:100, y:frame.size.height-50)
        smallHeart3.position=CGPoint(x:150, y:frame.size.height-50)
        //define positions of the hearts to top left.
        smallHeart.setScale(0.5)
        smallHeart2.setScale(0.5)
        smallHeart3.setScale(0.5)
        addChild(smallHeart)
        addChild(smallHeart2)
        addChild(smallHeart3)
        smallHeart2.position.y=2*frame.size.height
        smallHeart3.position.y=2*frame.size.height
        //put the 2 after hearts to disappear
        smallCryst.setScale(0.1)
        smallCryst.position=CGPoint(x:50, y:frame.size.height-100)
        addChild(smallCryst)
        marklbl.text = String(mark)
        marklbl.fontSize = 30
        marklbl.fontColor = SKColor.black
        marklbl.position = CGPoint(x:100, y:frame.size.height-120)
        addChild(marklbl)
     
        markPluslbl.text="+5"
        markPluslbl.fontColor = SKColor.black
        self.markPluslbl.position = CGPoint(x:marklbl.position.x + 50, y:marklbl.position.y)
        
        addChild(markPluslbl)
        addChild(backGrMusic)
        addChild(shooting)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !collided && !fail else {
            return
        }
            let dilation=frame.size.height/414.0  //use the height of frame to declare proper speed figure
            if person.position.y == 0.5*self.person.frame.height + 20 {  // if the person is at the ground
                jumpSpeed = -18*dilation  //the speed of elevation is 18
                person.removeAction(forKey: "running") //stop the animation when in the air
            }
        if laserCatched{
//            laser schiesen
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !collided && !fail else {
            return
        }
        let dilation=frame.size.height/414.0  //use the height of frame to declare proper speed figure
        if jumpSpeed < -10*dilation{  //if the jumpSpeed is greater than 10
            jumpSpeed = -10*dilation  //lower the jumpSpeed it to 10, in order to make it land quickly
        }
    }
    override func update(_ currentTime: TimeInterval) {
        guard !collided && !fail else {
            return
        }
        let dilation=frame.size.height/414.0     //use the height of frame to declare proper speed figure
        let smallHeartArray=[smallHeart,smallHeart2,smallHeart3]
        jumpSpeed+=0.6*dilation   //the jump speed decreases because of the affect of gravity
        person.position.y-=jumpSpeed
        laserGun.position.y-=jumpSpeed    //the person moves up and down based on the speed

        backgroundImage.position.x-=backgroundSpeed
        
        //move blocks
        block.position.x-=blockSpeed
        
        if block.position.x < -block.size.width/2{  //block passes the screen
            reLocateBlock() //relocate
            mark+=1 //add mark if it passes the block1
            markPlus(score: 1) //display the mark increase
        if blockSpeed<12{
                runningSpeed=runningSpeed*Double(speedIndex)     // blockSpeed=blockSpeed/speedIndex
                birdSpeed=birdSpeed/speedIndex //increase speed of all objects only when blockSpeed<12
            }
        }

       if person.position.y < 0.5*person.frame.height + 20 {    //if the person is on the ground
        person.position.y=0.5*person.frame.height + 20      //don't let it go down, which will go out of bound.
        }
        if laserGun.position.y < 200.0 {
            laserGun.position.y = 200.0         //make laser shot on the ground
        }
        
        if jumpSpeed>0 && /*person.position.y<0.7*person.frame.height &&*/ 0.5*person.frame.height + 20<person.position.y {
            //when it lands
            if boneCatched{   //if it is carrying a laser gun
                person.run(SKAction.repeatForever(laserAction(x: runningSpeed)), withKey:"running")
                if laserShots <= 0 {
                    LaserDisappear()
                    boneCatched=false
                }
                laserGun.position = CGPoint(x: person.position.x + 100, y:0)
                let move = SKAction.moveBy(x: 200, y: 0, duration: 0.4)
                let remove = SKAction.removeFromParent()
                let sequence = SKAction.sequence([move, remove])
                laserGun.run(sequence)

            }else{
                person.run(SKAction.repeatForever(RunningAction(x: runningSpeed)), withKey:"running")
                boneCatched=false
            }
            
        }
//running on ground with laser ???????
        if laserCatched && person.position.y<=0.5*person.frame.height  {
            LaserAppear()
            /*if laserGun.position.x < 1.3*size.width{
                    laserCatched=false                       //make laser gun dismissed
                    person.removeAction(forKey: "running")  //when the new laser gun is coming
                    person.run(SKAction.repeatForever(RunningAction(x: runningSpeed)), withKey:"running")   //running animation back to regular
            }*/
        }
        
        bird.position.x-=birdSpeed                   //the bird moves by birdSpeed everytime to left
        if bird.position.x < -bird.size.width/2{     //if it is outside the screen
            reLocateBird()
        }
        crystal.position.x-=birdSpeed              //the laserGun moves by birdSpeed everytime to left
        if crystal.position.x < -crystal.size.width/2{              //if it is outside the screen
            relocateCrystal()
        }
        if checkIfCrystal(object:block){
            laserGun.run(laserGunLoadedSound)
            boneCatched=true
            LaserAppear()
            reLocateBlock()
        }
        if checkIfCrystal(object:bird){
            collided=true
            collideResult()
            laserCatched=false
            LaserDisappear()
            lifes-=1
            if lifes<=0{  //when no life
                fail=true  //failed the game
                ifFail() //run function for fail condition
            }
            else{
                smallHeartArray[lifes].position.y=2*frame.size.height  //one heart disappears
            }
        }
            
        if checkIfCrystal(object:crystal){
            person.run(lifeGotSound)
            mark += 1
            relocateCrystal()
            let jump0 = SKTexture.init(imageNamed: "player-jump-crystal0")
            let jump1 = SKTexture.init(imageNamed: "player-jump-crystal1")
            let runningArray=[jump0,jump1,jump0,jump1,jump0,jump1]
            let runningAnimation = SKAction.animate(with: runningArray, timePerFrame: 0.5)
            person.run(runningAnimation)
        }
        if checkIfCrystal(object:heart){               //detect the collision between heart and person
            person.run(lifeGotSound)
            if lifes<=2{                                 //when it doesn't have more lifes than2
            lifes+=1
            smallHeartArray[lifes-1].position.y=frame.size.height-0.75*smallHeart.size.height//give him a life
            }
            relocateHeart()
            //relocate teh heart to let it come again
        }
        if checkIfLaser(object:bird){
            hitTheBird()
        }
        heart.position.x-=birdSpeed     //move the heart
        marklbl.text=String(mark)       //refresh mark
        
    }
}
