//
//  MovementComponent.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 17/06/25.
//

import GameplayKit

class MovementComponent: GKComponent {
    var joystickDirection = CGVector.zero
    var speed: CGFloat = 200 * 5
    
    weak var spriteNode: SKSpriteNode?
    
    var runFrames1: [SKTexture] = []
    var runFrames2: [SKTexture] = []
    var idleFrames: [SKTexture] = []
    var audioFootstep: SKAction!
    
    private var isRunning: Bool = false
    
    override func update(deltaTime seconds: TimeInterval) {
            guard let sprite = spriteNode else { return }

            let dx = joystickDirection.dx * speed * CGFloat(seconds)
            sprite.position.x += dx
            
            handleAnimation(sprite: sprite)
        }
    
    func setDirection(_ direction: CGVector) {
        joystickDirection = direction
    }
        
    private func handleAnimation(sprite: SKSpriteNode) {
        let isMoving = abs(joystickDirection.dx) > 0.1
        
        // Flip direction
        if isMoving {
            let direction: CGFloat = joystickDirection.dx > 0 ? 1 : -1
            let newXScale = direction * abs(sprite.yScale)
            if sprite.xScale != newXScale {
                sprite.xScale = newXScale
            }
        }
        
        if isMoving && sprite.action(forKey: "run") == nil {
            sprite.removeAction(forKey: "idle")
            let run1 = SKAction.animate(with: runFrames1, timePerFrame: 0.1)
            let run2 = SKAction.animate(with: runFrames2, timePerFrame: 0.1)
            let footstep = audioFootstep ?? SKAction.wait(forDuration: 0.1)
            let sequence = SKAction.sequence([run1, footstep, run2])
            sprite.run(SKAction.repeatForever(sequence), withKey: "run")
        } else if !isMoving && sprite.action(forKey: "idle") == nil {
            sprite.removeAction(forKey: "run")
            let idle = SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: 0.3))
            sprite.run(idle, withKey: "idle")
        }
    }
}
