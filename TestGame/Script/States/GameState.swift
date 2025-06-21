//
//  GameState.swift
//  TestGame
//
//  Created by Steven Gonawan on 19/06/25.
//

import GameplayKit

class GameState: GKState {
    unowned let scene: GameScene
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
}
