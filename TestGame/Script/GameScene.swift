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
    
    var stateMachine: GKStateMachine!
    
    private func setupStateMachine() {
        let states: [GKState] = [
            PlayingState(scene: self),
            DialogState(scene: self),
            PauseState(scene: self),
            QuestListState(scene: self)
        ]
        stateMachine = GKStateMachine(states: states)
        stateMachine.enter(PlayingState.self)
    }
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var playerEntity: PlayerEntity!
    
    var lastUpdateTime : TimeInterval = 0
    var label : SKLabelNode?
    var ground: SKSpriteNode?
    var spawnPoint: CGPoint?
    var virtualController: GCVirtualController?
    var contactedNpcId: String?
    var dialogSystem = DialogSystem()
    var visNovNode = SKVisNovNode()
    var runFrames1: [SKTexture] = []
    var runFrames2: [SKTexture] = []
    var idleFrames: [SKTexture] = []
    var audioFootstep: SKAction!
    var joystickDirection = CGVector.zero
    
    var pauseButton: SKSpriteNode!
    
    var backgroundBg: ParrallaxBackground!
    var farthestBg: ParrallaxBackground!
    var farBg: ParrallaxBackground!
    var midBg: ParrallaxBackground!
    var nearestBg: ParrallaxBackground!
    var effectBg: ParrallaxBackground!
    
    override func sceneDidLoad() {
        
        super.sceneDidLoad()
        setupStateMachine()
        self.physicsWorld.contactDelegate = self
        
        setupSpawnPoint()
        setupGround()
        setupPlayer()
        setupCameraPlayer()
        setupNpc()
        setupParallax()
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
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let node = self.atPoint(location) as? SKLabelNode, node.name == "questCloseLabel" {
            print("Quest List Closed")
            stateMachine.enter(PauseState.self)
            return
        }
        
        if let node = self.atPoint(location) as? SKSpriteNode, node.name == "pauseQuestIcon" {
            print("Quest List Opened")
            stateMachine.enter(QuestListState.self)
            return
        }

        if let node = self.atPoint(location) as? SKSpriteNode, node.name == "pauseButton" {
            print("Pause button tapped")
            stateMachine.enter(PauseState.self)
            return
        }
        
        if let node = self.atPoint(location) as? SKSpriteNode, node.name == "closeButton" {
            print("Close button tapped")
            stateMachine.enter(PlayingState.self)
            return
        }
        
        if visNovNode.isHidden == false {
            dialogSystem.showNextDialogLine()
            return
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }
        
        let deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        stateMachine.update(deltaTime: deltaTime)
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
            print("[spawnPoint] not found!")
        }
    }
    
    func setupPlayer() {
        guard let spawn = spawnPoint else {
            print("Spawn point not set.")
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
        
        if let questComponent = playerEntity.component(ofType: QuestComponent.self) {
            for quest in allQuests {
                questComponent.addQuest(quest)
            }
        }
        
        GameManager.shared.playerEntity = playerEntity
    }
    
    func setupCameraPlayer() {
        guard let cameraNode = self.childNode(withName: "//SKCameraNode") as? SKCameraNode else {
            print("Camera node not found")
            return
        }
        
        self.camera = cameraNode
    }
    
    func setupNpc() {
        if let npcNode = self.childNode(withName: "//npc_guardian") as? SKSpriteNode {
            npcNode.zPosition = -1
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
    
    func setupParallax() {
        self.backgroundBg = ParrallaxBackground(imageName: "Background", imageScaler: 0.5, zPos: -6, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.farthestBg = ParrallaxBackground(imageName: "TreeVeryBack", imageScaler: 0.5, zPos: -5, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.farBg = ParrallaxBackground(imageName: "TreeBack", imageScaler: 0.5, zPos: -4, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.effectBg = ParrallaxBackground(imageName: "LightEffect", imageScaler: 0.5, zPos: -3, xPos: 80.893, yPos: -330.587, scene: self, minTiles: 4, maxTiles: 6, blendMode: .add, randomZMin: -5, randomZMax: -1)
        self.midBg = ParrallaxBackground(imageName: "TreeFront", imageScaler: 0.5, zPos: -2, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.nearestBg = ParrallaxBackground(imageName: "TreeVeryFront", imageScaler: 0.5, zPos: -1, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
    }
}
