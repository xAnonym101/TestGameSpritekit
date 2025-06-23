//
//  PauseState.swift
//  TestGame
//
//  Created by Steven Gonawan on 20/06/25.
//

import GameplayKit

class PauseState: GameState {
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
                cameraNode.childNode(withName: "pauseButton")?.removeFromParent()
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
            
            // Quest list
            if let questComponent = scene.playerEntity.component(ofType: QuestComponent.self) {
                let quests = questComponent.quests
                
                let questListNode = SKNode()
                questListNode.name = "questListContainer"
                questListNode.zPosition = 101
                questListNode.position = CGPoint(x: 0, y: 0)
                cameraNode.addChild(questListNode)

                let spacing: CGFloat = 50
                let baseY = CGFloat(quests.count - 1) * spacing / 2

                for (i, quest) in quests.enumerated() {
                    let label = SKLabelNode(fontNamed: "Helvetica-Bold")
                    label.text = quest.name

                    if quest.isCompleted {
                        label.fontColor = .green
                        label.fontSize = 28
                    } else if quest.isActive {
                        label.fontColor = .white
                        label.fontSize = 32
                    } else {
                        label.fontColor = .gray
                        label.fontSize = 24
                    }

                    label.name = "questLabel_\(i)"
                    label.position = CGPoint(x: 0, y: baseY - CGFloat(i) * spacing)
                    questListNode.addChild(label)
                }
            }
        }
    }
    
    override func willExit(to nextState: GKState) {
        guard let cameraNode = scene.camera else { return }

        cameraNode.childNode(withName: "pauseQuestIcon")?.removeFromParent()
        cameraNode.childNode(withName: "pauseOverlay")?.removeFromParent()
        cameraNode.childNode(withName: "questListContainer")?.removeFromParent()
        cameraNode.childNode(withName: "questCloseLabel")?.removeFromParent()
        cameraNode.childNode(withName: "closeButton")?.removeFromParent()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        print("Game Resumed")
//        return stateClass == PlayingState.self || stateClass == QuestListState.self
        return stateClass == PlayingState.self
    }
}
