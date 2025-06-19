//
//  ParrallaxBacground.swift
//  TestGame
//
//  Created by Steven Gonawan on 19/06/25.
//

import SpriteKit

class ParrallaxBackground {
    let imageName: String
    let container: SKNode
    let imageScaler: CGFloat
    let zPos: CGFloat
    let yPos: CGFloat
    let xPos: CGFloat
    let minTiles: Int
    let maxTiles: Int
    weak var scene: SKScene?
    let randomZMin: CGFloat
    let randomZMax: CGFloat
    
    private let blendMode: SKBlendMode?
    private let texture: SKTexture


    init(imageName: String, imageScaler: CGFloat, zPos: CGFloat, xPos: CGFloat, yPos: CGFloat, scene: SKScene, minTiles: Int, maxTiles: Int, blendMode: SKBlendMode? = nil, randomZMin: CGFloat? = nil,
         randomZMax: CGFloat? = nil) {
        self.imageName = imageName
        self.imageScaler = imageScaler
        self.zPos = zPos
        self.xPos = xPos
        self.yPos = yPos
        self.minTiles = minTiles
        self.maxTiles = maxTiles
        self.scene = scene
        self.container = SKNode()
        self.texture = SKTexture(imageNamed: imageName)
        self.texture.filteringMode = .nearest
        self.blendMode = blendMode
        self.randomZMin = randomZMin ?? zPos
        self.randomZMax = randomZMax ?? zPos
        setupInitialBackground()
    }

    private func setupInitialBackground() {
        guard let scene = scene else { return }
        let tex = texture
        let scaledWidth = tex.size().width * imageScaler
        let count = max(minTiles, Int(ceil(scene.size.width / scaledWidth)) + 1)

        for i in 0..<count {
            let bg = SKSpriteNode(texture: tex)
            bg.anchorPoint = .zero
            bg.position = CGPoint(x: CGFloat(i) * scaledWidth - scaledWidth - xPos, y: yPos)
            bg.zPosition = CGFloat.random(in: randomZMin...randomZMax)
            bg.setScale(imageScaler)
            if let blendMode = self.blendMode {
                bg.blendMode = blendMode
            }
            container.addChild(bg)
        }

        scene.addChild(container)
    }

    func update(playerX: CGFloat, direction: CGFloat, speed: CGFloat) {
        guard let scene = scene else { return }
        let tex = texture
        let scaledWidth = tex.size().width * imageScaler

        // Move
        for node in container.children {
            node.position.x -= direction * speed
        }

        // Add to right
        if let rightmost = container.children.max(by: { $0.position.x < $1.position.x }),
           rightmost.position.x + scaledWidth < scene.size.width + playerX {
            addTile(at: rightmost.position.x + scaledWidth)
        }

        // Add to left
        if let leftmost = container.children.min(by: { $0.position.x < $1.position.x }),
           leftmost.position.x > playerX - scene.size.width {
            addTile(at: leftmost.position.x - scaledWidth)
        }

        // Trim
        if direction != 0 {
            while container.children.count > maxTiles {
                if direction > 0 {
                    container.children.sorted(by: { $0.position.x < $1.position.x }).first?.removeFromParent()
                } else {
                    container.children.sorted(by: { $0.position.x > $1.position.x }).first?.removeFromParent()
                }
            }
        }
    }

    private func addTile(at xPos: CGFloat) {
        guard !container.children.contains(where: { abs($0.position.x - xPos) < 1.0 }) else {
            return
        }

        let bg = SKSpriteNode(texture: texture)
        bg.anchorPoint = .zero
        bg.position = CGPoint(x: xPos, y: yPos)
        bg.zPosition = CGFloat.random(in: randomZMin...randomZMax)
        bg.setScale(imageScaler)
        if let blendMode = self.blendMode {
            bg.blendMode = blendMode
        }
        container.addChild(bg)

    }

}

