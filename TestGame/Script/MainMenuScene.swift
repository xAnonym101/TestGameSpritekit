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
        
        
        let startButton = SKButtonNode(
                texture: nil,
                size: CGSize(width: 400, height: 100),
                title: "Start",
                fontSize: 100,
                fontColor: .black,
                horizontalAlignment: .right,
                soundName: nil,
                action: {
                    print("Button clicked")
                    if let view = self.view {
                        if let newScene = GameScene(fileNamed: "GameScene") {
                            newScene.scaleMode = .aspectFill
                            view.presentScene(newScene)
                        }
                    }
                }
        )
        startButton.anchorPoint = .zero
        startButton.position = CGPoint(x: -100, y: -100)
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
