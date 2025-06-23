//
//  MainMenu.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 05/06/25.
//  Source: ChatGPT and edited by me
//

import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    
    //Unity's Awake() / Start()
    //Any variable should be init and/or any change from other should be init in here
    //Start
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        let background = SKSpriteNode(imageNamed: "Cover")
        background.name = "backgroundCover"
        background.zPosition = -100 // ensure it's behind other elements
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = self.size // 👈 stretch to fit device screen
        background.yScale = 0.87
        background.anchorPoint = CGPoint(x: 0.5, y: 0.53)

        addChild(background)
        
        
        let startTexture = SKTexture(imageNamed: "StartButtonTexture")
        let originalSize = startTexture.size()
        let scaleFactor: CGFloat = 0.5 // Scale to 50% of original size

        let startButton = SKButtonNode(
            texture: startTexture,
            size: CGSize(width: originalSize.width * scaleFactor,
                         height: originalSize.height * scaleFactor),
            title: " ",
            fontSize: 48,
            fontColor: .white,
            horizontalAlignment: .center,
            soundName: "click.wav",
            action: nil
        )

        let breatheIn = SKAction.scale(to: 1.05, duration: 1.5)
        breatheIn.timingMode = .easeInEaseOut
        let breatheOut = SKAction.scale(to: 0.95, duration: 1.5)
        breatheOut.timingMode = .easeInEaseOut
        let breatheSequence = SKAction.sequence([breatheIn, breatheOut])
        let breatheForever = SKAction.repeatForever(breatheSequence)

        startButton.run(breatheForever, withKey: "idle_animation")

        startButton.action = {
            startButton.removeAction(forKey: "idle_animation")
            
            let pressDown = SKAction.scale(to: 0.9, duration: 0.1)
            let pressUp = SKAction.scale(to: 1.0, duration: 0.1)
            let wait = SKAction.wait(forDuration: 0.05)

            startButton.run(.sequence([pressDown, pressUp, wait]), completion: {
                startButton.run(breatheForever, withKey: "idle_animation")
                
                if let view = startButton.scene?.view,
                   let newScene = GameScene(fileNamed: "GameScene") {
                    newScene.scaleMode = .aspectFill
                    let transition = SKTransition.fade(withDuration: 1.0)
                    view.presentScene(newScene, transition: transition)
                }
            })
        }

        startButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        startButton.position = CGPoint(x: 0, y: -150)
        addChild(startButton)

        
    }
    //End
    
    //Unity's OnCollisionEnter() or similiar function
    //Use for, well, touch
    //Start
//    func touchDown(atPoint pos : CGPoint) {
//    }
//    
//    func touchMoved(toPoint pos : CGPoint) {
//    }
//    
//    func touchUp(atPoint pos : CGPoint) {
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//
//        let location = touch.location(in: self)
//        let touchedNode = atPoint(location)
//
//        if let label = touchedNode as? SKLabelNode, label.name == self.label?.name {
//                print("Label tapped!")
//                // Perform action here, like switching scenes
//            self.label?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
    //End
    
    //Unity's Update() (not FixedUpdate() i think)
    //Any logic that occurs many time should be written in here
    //Start
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
//        let dt = currentTime - self.lastUpdateTime
        
        self.lastUpdateTime = currentTime
    }
    //End
}
