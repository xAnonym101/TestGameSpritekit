//
//  PlayerEntity.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 17/06/25.
//

import GameplayKit

class PlayerEntity: GKEntity {
    init(name: String = "Nephyr", texture: SKTexture, size: CGSize){
        super.init()
        addComponent(PlayerInfoComponent(name: name))
        addComponent(MovementComponent())
        addComponent(WispPointComponent())
        addComponent(InventoryComponent())
        addComponent(RenderComponent(texture: texture, size: size))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
