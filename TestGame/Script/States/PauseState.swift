//
//  PauseState.swift
//  TestGame
//
//  Created by Steven Gonawan on 20/06/25.
//

import GameplayKit

class PauseState: GameState {
    
    var bookOverlay: SKSpriteNode!
    
    override func didEnter(from previousState: GKState?) {
        scene.virtualController = nil
        print("Game Paused")
        
        // Pause button
        if let cameraNode = scene.camera {
            let closeButtonName = "closeButton"
            if cameraNode.childNode(withName: closeButtonName) == nil {
                let texture = SKTexture(imageNamed: "CloseIcon")
                texture.filteringMode = .nearest
                let closeButton = SKSpriteNode(texture: texture, size: CGSize(width: 70, height: 70))
                closeButton.name = closeButtonName
                closeButton.zPosition = 101
                cameraNode.addChild(closeButton)
                
                closeButton.position = CGPoint(
                    x: UIScreen.main.bounds.width * -0.6 - 80,
                    y: UIScreen.main.bounds.height * 0.4 + 80
                )
            }
            
            // Pause overlay
            let overlayName = "pauseOverlay"
            if cameraNode.childNode(withName: overlayName) == nil {
                let overlay = SKSpriteNode(color: .black, size: CGSize(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height * 2))
                overlay.alpha = 0.5
                overlay.name = overlayName
                overlay.zPosition = 100
                overlay.position = .zero
                cameraNode.addChild(overlay)
            }
            
            // Quest icon
            let bookOverlayName = "bookOverlay"
            if cameraNode.childNode(withName: bookOverlayName) == nil {
                let texture = SKTexture(imageNamed: "BookAll")
                texture.filteringMode = .nearest

                bookOverlay = SKSpriteNode(texture: texture)
                let screenWidth = UIScreen.main.bounds.width
                let desiredWidthRatio: CGFloat = 1.3 // 25% of screen width
                let targetWidth = screenWidth * desiredWidthRatio

                let originalWidth = texture.size().width
                let scale = targetWidth / originalWidth
                bookOverlay.setScale(scale)
                bookOverlay.name = bookOverlayName
                bookOverlay.zPosition = 101
                cameraNode.addChild(bookOverlay)
                bookOverlay.position = .zero
            }
            
            // Quest list
            if let questComponent = scene.playerEntity.component(ofType: QuestComponent.self),
               let cameraNode = scene.camera,
               let bookNode = cameraNode.childNode(withName: "bookOverlay") {

                let quests = questComponent.quests

                let questListNode = SKNode()
                questListNode.name = "questListContainer"
                questListNode.zPosition = 102 // one layer above the book

                // Position relative to the book node
                questListNode.position = CGPoint(
                    x: bookOverlay.position.x + 170,
                    y: bookOverlay.position.y + 100 // offset to appear toward top of book
                )
                cameraNode.addChild(questListNode)

                let spacing: CGFloat = 50
                let baseY = 0.0

                for (i, quest) in quests.enumerated() {
                    let label = SKLabelNode(fontNamed: "VT323")
                    label.text = quest.name

                    if quest.isCompleted {
                        label.fontColor = SKColor(red: 145/255.0, green: 150/255.0, blue: 87/255.0, alpha: 1.0)
                        label.fontSize = 24
                    } else if quest.isActive {
                        label.fontColor = SKColor(red: 145/255.0, green: 97/255.0, blue: 87/255.0, alpha: 1.0)
                        label.fontSize = 28
                    } else {
                        label.fontColor = .gray
                        label.fontSize = 24
                    }

                    label.name = "questLabel_\(i)"
                    label.position = CGPoint(x: 0, y: baseY - CGFloat(i) * spacing)
                    questListNode.addChild(label)
                }
            }
            
            if let inventoryComponent = scene.playerEntity.component(ofType: InventoryComponent.self),
               let cameraNode = scene.camera,
               let bookNode = cameraNode.childNode(withName: "bookOverlay") {
                
                let inventoryItems = inventoryComponent.items
                
                let inventoryListNode = SKNode()
                inventoryListNode.name = "inventoryListContainer"
                inventoryListNode.zPosition = 102
                
                inventoryListNode.position = CGPoint(
                    x: bookOverlay.position.x - 280,
                    y: bookOverlay.position.y - 60
                )
                cameraNode.addChild(inventoryListNode)
                
                let spacing: CGFloat = 50
                let baseY: CGFloat = 0
                
                for (index,(item, count)) in inventoryItems.enumerated() {
                    let label = SKLabelNode(fontNamed: "VT323")
                    label.text = "\(item) x\(count)"
                    label.fontColor = .black
                    label.fontSize = 24
                    label.name = "inventLabel_\(index)"
                    label.position = CGPoint(x: 0, y: baseY - CGFloat(index) * spacing)
                    inventoryListNode.addChild(label)
                }
            }
        }
    }
    
    override func willExit(to nextState: GKState) {
        guard let cameraNode = scene.camera else { return }

        cameraNode.childNode(withName: "pauseQuestIcon")?.removeFromParent()
        cameraNode.childNode(withName: "pauseOverlay")?.removeFromParent()
        cameraNode.childNode(withName: "bookOverlay")?.removeFromParent()
        cameraNode.childNode(withName: "questListContainer")?.removeFromParent()
        cameraNode.childNode(withName: "inventoryListContainer")?.removeFromParent()
        cameraNode.childNode(withName: "closeButton")?.removeFromParent()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        print("Game Resumed")
        return stateClass == PlayingState.self
    }
}
