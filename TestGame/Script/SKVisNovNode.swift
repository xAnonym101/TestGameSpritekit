//
//  SKVisNovNode.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 12/06/25.
//

import SpriteKit
import SwiftUI

class SKVisNovNode: SKNode {
    private let playerSprite = SKSpriteNode()
    private let npcSprite = SKSpriteNode()
    private let backgroundNode = SKSpriteNode()
    private let textNovNode = SKLabelNode()
    private let textNameNode = SKLabelNode()
    private let backgroundTextNode = SKSpriteNode(color: .black, size: .zero)
    
    private var choiceButtons : [SKButtonNode] = []
    private var onChoiceSelected : ((Int) -> Void)?
    private var buttonStartY = CGFloat()
    
    private var targetHeightPortrait : CGFloat = 500
    
    let baseFontSize: CGFloat = 20
    let minFontSize: CGFloat = 16
    let reductionPerWord: CGFloat = 0.25
    
    override init() {
        super.init()
        
        zPosition = 100
        
        // Semi-transparent bottom overlay
        backgroundNode.color = .black
        backgroundNode.alpha = 0.5
        backgroundNode.zPosition = 0
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        backgroundNode.size.width = scene?.size.width ?? 800
        backgroundNode.size.height = scene?.size.height ?? 800
        backgroundNode.position = CGPoint(x: 0, y: -frame.height / 2)
        addChild(backgroundNode)
        
        // Portraits
        playerSprite.alpha = 0.4
        playerSprite.anchorPoint = CGPoint(x: 0.5, y: 0)
        playerSprite.zPosition = 1
        addChild(playerSprite)
        
        npcSprite.alpha = 0.4
        npcSprite.anchorPoint = CGPoint(x: 0.5, y: 0)
        npcSprite.zPosition = 1
        addChild(npcSprite)
        
        // Dialog box background
        backgroundTextNode.color = .black
        backgroundTextNode.alpha = 1
        backgroundTextNode.size = CGSize(width: 600, height: 160)
        backgroundTextNode.zPosition = 1
        backgroundTextNode.position = CGPoint(x: 0, y: (-frame.height / 1.5)+(backgroundTextNode.size.height / 0.9))
        addChild(backgroundTextNode)
        
        // Positioning sprites bottom left/right
        playerSprite.position = CGPoint(x: backgroundTextNode.position.x - backgroundTextNode.size.width / 1.5, y: backgroundTextNode.position.y * 0.35)
        npcSprite.position = CGPoint(x: backgroundTextNode.position.x + backgroundTextNode.size.width / 1.5, y: backgroundTextNode.position.y * 0.35)
        
        // Name Label
        textNameNode.fontColor = .white
        textNameNode.fontSize = 24
        textNameNode.fontName = "AvenirNext-Bold"
        textNameNode.zPosition = 2
        textNameNode.position = CGPoint(x: 0, y: backgroundTextNode.size.height / 2 - 40)
        textNovNode.blendMode = .add
        backgroundTextNode.addChild(textNameNode)
        
        // Text label
        textNovNode.fontColor = .white
        textNovNode.fontSize = 20
        textNovNode.fontName = "AvenirNext-Regular"
        textNovNode.horizontalAlignmentMode = .center
        textNovNode.verticalAlignmentMode = .center
        textNovNode.preferredMaxLayoutWidth = backgroundTextNode.size.width * 0.7
        textNovNode.position = CGPoint(x: 0, y: -10)
        textNovNode.zPosition = 2
        textNovNode.numberOfLines = 0
        backgroundTextNode.addChild(textNovNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resizeBackgroundNode(to view: SKView) {
        guard let sceneSize = scene?.size else { return }

        // Example: full width, bottom 30% of screen
        backgroundNode.size = CGSize(width: sceneSize.width, height: sceneSize.height)
        
        buttonStartY = sceneSize.height * 0.6
    }
    
    func updateDialog(line: DialogLine, texture: SKTexture?, npcBubbleTexture: String?, npcTextColor: SKColor?) {
        textNameNode.text = line.speaker
        textNovNode.text = line.text
        
        let wordCount = line.text.split(separator: " ").count
        let scaledSize = max(minFontSize, baseFontSize - (CGFloat(wordCount) * reductionPerWord))
        textNovNode.fontSize = scaledSize


        // Determine who is speaking and update alpha
        if let texture = texture {
            let aspectRatio = texture.size().width / texture.size().height
            let targetWidth = targetHeightPortrait * aspectRatio
            let newSize = CGSize(width: targetWidth, height: targetHeightPortrait)

            if line.speaker == GameManager.shared.playerEntity?.component(ofType: PlayerInfoComponent.self)?.name {
                playerSprite.texture = texture
                playerSprite.size = newSize
                playerSprite.alpha = 1.0
                npcSprite.alpha = 0.4
                
                backgroundTextNode.texture = SKTexture(imageNamed: "bubble-player")
                backgroundNode.texture?.filteringMode = .nearest
                textNameNode.fontColor = .white
                textNovNode.fontColor = .white
            } else {
                npcSprite.texture = texture
                npcSprite.size = newSize
                npcSprite.alpha = 1.0
                playerSprite.alpha = 0.4
                
                backgroundTextNode.texture = SKTexture(imageNamed: npcBubbleTexture ?? "bubble-npc")
                backgroundNode.texture?.filteringMode = .nearest
                textNameNode.fontColor = npcTextColor ?? .white
                textNovNode.fontColor = npcTextColor ?? .white
            }
            
        } else {
            // If no texture provided, fallback to dim both
            playerSprite.alpha = 0.4
            npcSprite.alpha = 0.4
        }
    }
    
    func clearDialog() {
        textNameNode.text = ""
        textNovNode.text = ""
        playerSprite.texture = nil
        npcSprite.texture = nil
        hideChoices()
    }
    
    func showChoices(choices: [DialogChoice], onSelected: @escaping (Int) -> Void) {
        hideChoices()
        self.onChoiceSelected = onSelected

        let buttonWidth: CGFloat = 300
        let buttonHeight: CGFloat = 50
        let spacing: CGFloat = 20
//        let startY = scene?.frame.maxY ?? 0 + 100

        for (index, choice) in choices.enumerated() {
            let button = SKButtonNode(
                texture: nil,
                color: .white,
                size: CGSize(width: buttonWidth, height: buttonHeight),
                title: "\(choice.text)",
                fontSize: 18,
                fontColor: .black,
                verticalAlignment: .center,
                horizontalAlignment: .center,
                soundName: "UIButton.wav"
            ) {
                onSelected(index)
                self.hideChoices()
            }

            button.name = "choice_\(index)"
            button.position = CGPoint(
                x: 0,
                y: buttonStartY - CGFloat(index) * (buttonHeight + spacing * 1.5)
            )
            button.zPosition = 150
            addChild(button)
            choiceButtons.append(button)
        }

    }
    
    func hideChoices() {
        for label in choiceButtons {
            label.removeFromParent()
        }
        choiceButtons.removeAll()
        onChoiceSelected = nil
    }

    func handleTouch(at point: CGPoint) {
        for (index, label) in choiceButtons.enumerated() {
            if label.contains(point) {
                onChoiceSelected?(index)
                hideChoices()
                break
            }
        }
    }
    
    func calculateHeight() -> CGFloat {
        return backgroundNode.size.height
    }
}
