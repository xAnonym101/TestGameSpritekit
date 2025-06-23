//
//  GameManager.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 21/06/25.
//

import Foundation

class GameManager {
    static let shared = GameManager()
    
    var playerEntity: PlayerEntity?
    private init() {}
}
