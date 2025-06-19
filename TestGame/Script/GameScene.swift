//
//  GameScene.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 04/06/25.
//

import SpriteKit
import GameplayKit
import GameController


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var playerEntity: PlayerEntity!
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var ground: SKSpriteNode?
    private var spawnPoint: CGPoint?
    private var virtualController: GCVirtualController?
    private var contactedNpcId: String?
    private var dialogSystem = DialogSystem()
    private var visNovNode = SKVisNovNode()
    var runFrames1: [SKTexture] = []
    var runFrames2: [SKTexture] = []
    var idleFrames: [SKTexture] = []
    var audioFootstep: SKAction!
    var joystickDirection = CGVector.zero
    
    var backgroundBg: ParrallaxBackground!
    var farthestBg: ParrallaxBackground!
    var farBg: ParrallaxBackground!
    var midBg: ParrallaxBackground!
    var nearestBg: ParrallaxBackground!
    var effectBg: ParrallaxBackground!
    
    
    
    override func sceneDidLoad() {
        
        print("GameScene loaded")
        
        self.lastUpdateTime = 0
        
        physicsWorld.contactDelegate = self
        
        setupSpawnPoint()
        setupGround()
        setupPlayer()
        setupCameraPlayer()
        setupControllerHandlers()
        setupNpc()
        self.backgroundBg = ParrallaxBackground(imageName: "Background", imageScaler: 0.5, zPos: -6, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.farthestBg = ParrallaxBackground(imageName: "TreeVeryBack", imageScaler: 0.5, zPos: -5, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.farBg = ParrallaxBackground(imageName: "TreeBack", imageScaler: 0.5, zPos: -4, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.effectBg = ParrallaxBackground(imageName: "LightEffect", imageScaler: 0.5, zPos: -3, xPos: 80.893, yPos: -330.587, scene: self, minTiles: 4, maxTiles: 6, blendMode: .add, randomZMin: -5, randomZMax: -1)
        self.midBg = ParrallaxBackground(imageName: "TreeFront", imageScaler: 0.5, zPos: -2, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.nearestBg = ParrallaxBackground(imageName: "TreeVeryFront", imageScaler: 0.5, zPos: -1, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
    }
        
    override func didMove(to view: SKView) {
        visNovNode.position = CGPoint(
            x: frame.midX,
            y: frame.minY
        )
        visNovNode.scene?.size = self.size
        self.camera?.addChild(visNovNode)
        visNovNode.resizeBackgroundNode(to: self.view!)
        visNovNode.isHidden = true
        setupDialogSystem()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let names = [contact.bodyA.node?.name, contact.bodyB.node?.name]
        if let npcName = names.first(where: { $0?.starts(with: "npc_") == true }) {
            contactedNpcId = npcName
            print("Player contacted: \(npcName!)")
        }
    }

    func didEnd(_ contact: SKPhysicsContact) {
        let names = [contact.bodyA.node?.name, contact.bodyB.node?.name]
        if let npcName = names.compactMap({ $0 }).first(where: { $0 == contactedNpcId }) {
            contactedNpcId = nil
            print("Player left: \(npcName)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if visNovNode.isHidden == false {
            dialogSystem.showNextDialogLine()
            return
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    override func update(_ currentTime: TimeInterval) {
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        
        let dt = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
        
        if let movement = playerEntity.component(ofType: MovementComponent.self) {
            movement.setDirection(joystickDirection)
        }
        
        playerEntity.update(deltaTime: dt)

        guard let camera = self.camera,
              let playerNode = playerEntity.component(ofType: RenderComponent.self)?.node else { return }

        camera.position = CGPoint(x: playerNode.position.x, y: playerNode.position.y + 150)

        // 👇 Parallax update
        let dx = joystickDirection.dx
        let px = playerNode.position.x

        // Smaller speed = slower background = further away
        backgroundBg.update(playerX: px, direction: dx, speed: 0.02)
        farthestBg.update(playerX: px, direction: dx, speed: 0.04)
        farBg.update(playerX: px, direction: dx, speed: 0.07)
        effectBg.update(playerX: px, direction: dx, speed: 0.07)
        midBg.update(playerX: px, direction: dx, speed: 0.1)
        nearestBg.update(playerX: px, direction: dx, speed: 0.0)
    }
    
    func setupGround() {
        self.ground = self.childNode(withName: "//ground") as? SKSpriteNode
        if let ground = self.ground {
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.isDynamic = false
            ground.physicsBody?.categoryBitMask = PhysicsCategory.ground
        }
    }
    
    func setupSpawnPoint() {
        if let spawnNode = self.childNode(withName: "//spawnPoint") {
            spawnPoint = spawnNode.position
        } else {
            print("⚠️ spawnPoint not found!")
        }
    }
    
    func setupControllerHandlers() {
        setupVirtualController()
    }
    
    func setupVirtualController() {
        let virtualConfiguration = GCVirtualController.Configuration()

        virtualConfiguration.elements = [GCInputLeftThumbstick,
                                         GCInputButtonA,
                                         GCInputButtonB]
        virtualController = GCVirtualController(configuration: virtualConfiguration)
        virtualController?.connect()
        if let gamepad = virtualController?.controller?.extendedGamepad {
            gamepad.leftThumbstick.valueChangedHandler = { [weak self] _, x, y in
                self?.joystickDirection = CGVector(dx: CGFloat(x), dy: 0)
            }
            
            gamepad.buttonA.pressedChangedHandler = { [weak self] _,_, pressed in
                if pressed {
                    self?.tryStartNpcDialog()
                }
            }
        }
    }
    
    func setupPlayer() {
        guard let spawn = spawnPoint else {
            print("⚠️ Spawn point not set.")
            return
        }

        let textureAtlas = SKTextureAtlas(named: "MC-Idle")
        let idleFrames = (1...3).map { textureAtlas.textureNamed("MCidle\($0)") }
        let idleTexture = idleFrames[0]
        
        let textureAtlas2 = SKTextureAtlas(named: "MC-Run")
        runFrames1 = (1...2).map { textureAtlas2.textureNamed("MCRun\($0)") }
        runFrames2 = (3...4).map { textureAtlas2.textureNamed("MCRun\($0)") }
        audioFootstep = SKAction.playSoundFileNamed("Player_Walk.wav", waitForCompletion: false)
        let size = CGSize(width: idleTexture.size().width * 3, height: idleTexture.size().height * 3)

        playerEntity = PlayerEntity(texture: idleTexture, size: size)
        
        idleFrames.forEach { $0.filteringMode = .nearest }
        runFrames1.forEach { $0.filteringMode = .nearest }
        runFrames2.forEach { $0.filteringMode = .nearest }

        if let renderNode = playerEntity.component(ofType: RenderComponent.self)?.node {
            renderNode.position = spawn
            renderNode.setScale(0.15)
            renderNode.texture?.filteringMode = .nearest
            renderNode.physicsBody = SKPhysicsBody(rectangleOf: renderNode.size)
            renderNode.physicsBody?.categoryBitMask = PhysicsCategory.player
            renderNode.physicsBody?.contactTestBitMask = PhysicsCategory.ground
            renderNode.physicsBody?.collisionBitMask = PhysicsCategory.ground
            renderNode.physicsBody?.allowsRotation = false
            addChild(renderNode)
        }
        
        if let movement = playerEntity.component(ofType: MovementComponent.self),
           let renderNode = playerEntity.component(ofType: RenderComponent.self)?.node as? SKSpriteNode {

            movement.spriteNode = renderNode
            movement.idleFrames = idleFrames
            movement.runFrames1 = runFrames1
            movement.runFrames2 = runFrames2
            movement.audioFootstep = audioFootstep
        }


        entities.append(playerEntity)
    }
    
    func setupCameraPlayer() {
        guard let cameraNode = self.childNode(withName: "//SKCameraNode") as? SKCameraNode else {
            print("⚠️ Camera node not found")
            return
        }
        
        self.camera = cameraNode // Assign camera to scene
    }
    
    func setupNpc() {
        if let npcNode = self.childNode(withName: "//npc_guardian") as? SKSpriteNode {
            npcNode.zPosition = 0
            npcNode.physicsBody = SKPhysicsBody(rectangleOf: npcNode.size)
            npcNode.physicsBody?.categoryBitMask = PhysicsCategory.npc
            npcNode.physicsBody?.contactTestBitMask = PhysicsCategory.player
            npcNode.physicsBody?.collisionBitMask = PhysicsCategory.ground
            npcNode.physicsBody?.isDynamic = false
            npcNode.physicsBody?.allowsRotation = false
            npcNode.physicsBody?.affectedByGravity = true
            
            let textureAtlas = SKTextureAtlas(named: "Guardian-Idle")
            let idleFrames = (1...3).map {textureAtlas.textureNamed("Gatekeeperidle\($0)") }
            idleFrames.forEach { $0.filteringMode = .nearest }
            let idleAction = SKAction.repeatForever(
                    SKAction.animate(with: idleFrames, timePerFrame: 0.3)
            )
            npcNode.run(idleAction, withKey: "idle")
        }
    }
    
    func setupDialogSystem() {
        dialogSystem.setPlayerPortraits(playerPortrait)
        dialogSystem.registerDialogTree(npcGuardian)

        dialogSystem.onDialogLineDisplayed = { [weak self] line, portrait in
            let texture = portrait != nil ? SKTexture(imageNamed: portrait!) : nil
            self?.visNovNode.updateDialog(line: line, texture: texture)
        }

        dialogSystem.onChoicesPresented = { [weak self] choices in
            self?.visNovNode.showChoices(choices: choices) { index in
                self?.dialogSystem.selectChoice(choices[index])
            }
        }

        dialogSystem.onDialogEnded = { [weak self] in
            self?.visNovNode.clearDialog()
            self?.visNovNode.isHidden = true
//            #if os(iOS)
            self?.virtualController?.connect()
//            #endif
        }
    }
    
    func tryStartNpcDialog() {
        guard let npcId = contactedNpcId else { return }
        print("Starting dialog with: \(npcId)")
        dialogSystem.startDialog(npcId: npcId, state: "quest_01")
        visNovNode.isHidden = false
        virtualController?.disconnect()
    }
}
