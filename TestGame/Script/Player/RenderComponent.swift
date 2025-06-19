//
//  RenderComponent.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 18/06/25.
//

import GameplayKit

class RenderComponent: GKComponent {
    let node: SKSpriteNode
    
    init(texture: SKTexture?, size: CGSize) {
        self.node = SKSpriteNode(texture: texture, color: .clear, size: size)
        self.node.name = "player"
        self.node.zPosition = 1
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
