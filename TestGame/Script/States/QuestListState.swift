//
//  QuestListState.swift
//  TestGame
//
//  Created by Steven Gonawan on 20/06/25.
//

import GameplayKit
import SpriteKit

class QuestListState: GameState {
    override func didEnter(from previousState: GKState?) {
        print("Quest List Opened")
        scene.virtualController = nil

        guard let cameraNode = scene.camera else { return }

        // Overlay
        let overlayName = "questOverlay"
        if cameraNode.childNode(withName: overlayName) == nil {
            let overlay = SKSpriteNode(color: .black, size: CGSize(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height * 2))
            overlay.alpha = 0.5
            overlay.name = overlayName
            overlay.zPosition = 100
            overlay.position = .zero
            cameraNode.addChild(overlay)
        }

        // [close] label
        let closeLabelName = "questCloseLabel"
        if cameraNode.childNode(withName: closeLabelName) == nil {
            let closeLabel = SKLabelNode(fontNamed: "Helvetica-Bold")
            closeLabel.text = "[close]"
            closeLabel.fontSize = 36
            closeLabel.fontColor = .white
            closeLabel.name = closeLabelName
            closeLabel.zPosition = 101
            closeLabel.position = CGPoint(
                x: UIScreen.main.bounds.width * -0.6,
                y: UIScreen.main.bounds.height * 0.4
            )
            cameraNode.addChild(closeLabel)
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

    override func willExit(to nextState: GKState) {
        guard let cameraNode = scene.camera else { return }

        cameraNode.childNode(withName: "questOverlay")?.removeFromParent()
        cameraNode.childNode(withName: "questListContainer")?.removeFromParent()
        cameraNode.childNode(withName: "questCloseLabel")?.removeFromParent()

        for child in cameraNode.children where child.name?.starts(with: "questLabel_") == true {
            child.removeFromParent()
        }
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == PauseState.self
    }
}
