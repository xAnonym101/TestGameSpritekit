//
//  GameScene.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 04/06/25.
//

import SpriteKit
//import GameplayKit
import GameController


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //    var entities = [GKEntity]()
    //    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var ground: SKNode?
    private var player: SKSpriteNode!
    private var spawnPoint: CGPoint?
//    #if os(iOS)
    private var virtualController: GCVirtualController?
//    #endif
//    private var physicController: GCController?
    private var contactedNpcId: String?
    private var dialogSystem = DialogSystem()
    private var visNovNode = SKVisNovNode()
    private var cameraPlayer: SKCameraNode?
    var runFrames1: [SKTexture] = []
    var runFrames2: [SKTexture] = []
    var idleFrames: [SKTexture] = []
    var audioFootstep: SKAction!
    var joystickDirection = CGVector.zero
    
<<<<<<< Updated upstream
    //    var backgroundContainer = SKNode()
    //    var backgroundImageName = "forest-2"
    //    var backgroundImageScaler: CGFloat = 2.9
    var foregroundLayer: BackgroundLayer!
    var midLayer: BackgroundLayer!
=======
    var backgroundBg: ParrallaxBackground!
    var farthestBg: ParrallaxBackground!
    var farBg: ParrallaxBackground!
    var midBg: ParrallaxBackground!
    var nearestBg: ParrallaxBackground!
    var effectBg: ParrallaxBackground!
    
>>>>>>> Stashed changes
    
    
    override func sceneDidLoad() {
        
        print("GameScene loaded")
        
        self.lastUpdateTime = 0
        
        physicsWorld.contactDelegate = self
        
        setupSpawnPoint()
        //        setupGround()
        setupPlayer()
        setupCameraPlayer()
        setupControllerHandlers()
        setupNpc()
<<<<<<< Updated upstream
        loadTileMap()
        //        if let tileMap = self.childNode(withName: "GroundTileMap") as? SKTileMapNode {
        //            setupPhysicsForTileMap(tileMap: tileMap, targetTileName: "grass-tile", physicsCategory: PhysicsCategory.ground)
        //        }
        
=======
        self.backgroundBg = ParrallaxBackground(imageName: "Background", imageScaler: 0.5, zPos: -6, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.farthestBg = ParrallaxBackground(imageName: "TreeVeryBack", imageScaler: 0.5, zPos: -5, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.farBg = ParrallaxBackground(imageName: "TreeBack", imageScaler: 0.5, zPos: -4, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.effectBg = ParrallaxBackground(imageName: "LightEffect", imageScaler: 0.5, zPos: -3, xPos: 80.893, yPos: -330.587, scene: self, minTiles: 4, maxTiles: 6, blendMode: .add, randomZMin: -5, randomZMax: -1)
        self.midBg = ParrallaxBackground(imageName: "TreeFront", imageScaler: 0.5, zPos: -2, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
        self.nearestBg = ParrallaxBackground(imageName: "TreeVeryFront", imageScaler: 0.5, zPos: -1, xPos: -90.893, yPos: -330.587, scene: self, minTiles: 3, maxTiles: 4)
>>>>>>> Stashed changes
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
        midLayer = BackgroundLayer(imageName: "forest-2", imageScaler: 1.3, zPos: -10, xPos: 1500, yPos: -370, scene: self, minTiles: 5, maxTiles: 6)
        foregroundLayer = BackgroundLayer(imageName: "forest-1", imageScaler: 2.3, zPos: -5, xPos: 1200, yPos: -650, scene: self, minTiles: 3, maxTiles: 4)
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
<<<<<<< Updated upstream
        
        let baseSpeed: CGFloat = 200
        let dx = joystickDirection.dx * baseSpeed * CGFloat(dt)
        
        player.position.x += dx
        if let cameraPlayer = self.camera, let player = player {
            cameraPlayer.position = CGPoint(x: player.position.x, y: player.position.y+150)
            self.camera?.xScale = 0.8
            self.camera?.yScale = 0.8
            if abs(dx) > 0.1 {
                foregroundLayer.update(playerX: player.position.x, direction: dx, speed: 0.0)
                midLayer.update(playerX: player.position.x, direction: dx, speed: 0.05)
            }
        }
=======
        
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
>>>>>>> Stashed changes
    }
    
    
    //    func setupGround() {
    //
    //        if let tileMap = self.childNode(withName: "///tileMap") as? SKTileMapNode {
    ////            self.ground = tileMap
    ////
    ////            // Create a single physics body covering the entire tilemap
    ////            tileMap.physicsBody = SKPhysicsBody(edgeLoopFrom: tileMap.frame)
    ////            tileMap.physicsBody?.isDynamic = false
    ////            tileMap.physicsBody?.categoryBitMask = PhysicsCategory.ground
    ////            tileMap.physicsBody?.contactTestBitMask = PhysicsCategory.player
    ////            tileMap.physicsBody?.collisionBitMask = PhysicsCategory.player
    //
    //            let tileSize = tileMap.tileSize
    //
    //            for col in 0..<tileMap.numberOfColumns {
    //                for row in 0..<tileMap.numberOfRows {
    //                    guard let definition = tileMap.tileDefinition(atColumn: col, row: row),
    //                          definition.userData?["isSolid"] as? Bool == true else {
    //                        continue
    //                    }
    //
    //                    // Create a physics body for this tile
    //                    let node = SKNode()
    //                    let x = CGFloat(col) * tileSize.width + tileSize.width / 2
    //                    let y = CGFloat(row) * tileSize.height + tileSize.height / 2
    //                    node.position = CGPoint(x: x, y: y)
    //                    node.physicsBody = SKPhysicsBody(rectangleOf: tileSize)
    //                    node.physicsBody?.isDynamic = false
    //                    node.physicsBody?.categoryBitMask = PhysicsCategory.ground
    //                    node.physicsBody?.collisionBitMask = PhysicsCategory.player
    //                    node.physicsBody?.contactTestBitMask = PhysicsCategory.player
    //
    //                    tileMap.addChild(node)
    //                }
    //            }
    //        }
    //    }
    
    func setupSpawnPoint() {
        if let spawnNode = self.childNode(withName: "//spawnPoint") {
            spawnPoint = spawnNode.position
        } else {
            print("⚠️ spawnPoint not found!")
        }
    }
    
    func setupControllerHandlers() {
//        #if os(iOS)
        // iPhone/iPad: Start with virtual controller
        setupVirtualController()

        // Observe for physical controllers
//        NotificationCenter.default.addObserver(forName: .GCControllerDidConnect, object: nil, queue: .main) { _ in
//            self.virtualController?.disconnect()
//            self.setupPhysicalController()
//        }
//
//        NotificationCenter.default.addObserver(forName: .GCControllerDidDisconnect, object: nil, queue: .main) { _ in
//            self.setupVirtualController()
//        }

//        #elseif os(macOS)
//        // Mac: Use keyboard input by default
//        setupKeyboardInput()
//
//        NotificationCenter.default.addObserver(forName: .GCControllerDidConnect, object: nil, queue: .main) { _ in
//            self.setupPhysicalController()
//        }
//        
//        NotificationCenter.default.addObserver(forName: .GCControllerDidDisconnect, object: nil, queue: .main) { _ in
//            self.setupKeyboardInput()
//        }
//        #endif
    }
    
//    func setupKeyboardInput() {
//        GCKeyboard.coalesced?.keyboardInput?.keyChangedHandler = { [weak self] _,_, keyCode, pressed in
//            guard pressed else { return }
//
//            switch keyCode {
//            case .leftArrow:
//                self?.joystickDirection = CGVector(dx: -1, dy: 0)
//                self?.handleWalking()
//            case .rightArrow:
//                self?.joystickDirection = CGVector(dx: 1, dy: 0)
//                self?.handleWalking()
//            case .spacebar, .returnOrEnter:
//                self?.tryStartNpcDialog()
//            default:
//                break
//            }
//        }
//    }
    
    func setupPhysicalController() {
        guard let controller = GCController.controllers().first,
              let gamepad = controller.extendedGamepad else {
            return
        }

        gamepad.leftThumbstick.valueChangedHandler = { [weak self] _, x, y in
            self?.joystickDirection = CGVector(dx: CGFloat(x), dy: 0)
            self?.handleWalking()
        }

        gamepad.buttonA.pressedChangedHandler = { [weak self] _, _, pressed in
            if pressed {
                self?.tryStartNpcDialog()
            }
        }
    }
    
    func setupVirtualController() {
        //        #if os(iOS)
        let virtualConfiguration = GCVirtualController.Configuration()
        
        virtualConfiguration.elements = [GCInputLeftThumbstick,
                                         GCInputButtonA,
                                         GCInputButtonB]
        virtualController = GCVirtualController(configuration: virtualConfiguration)
        virtualController?.connect()
        if let gamepad = virtualController?.controller?.extendedGamepad {
            gamepad.leftThumbstick.valueChangedHandler = { [weak self] _, x, y in
                self?.joystickDirection = CGVector(dx: CGFloat(x), dy: 0)
                self?.handleWalking()
            }
            
            gamepad.buttonA.pressedChangedHandler = { [weak self] _,_, pressed in
                if pressed {
                    self?.tryStartNpcDialog()
                }
            }
        }
//        #endif
    }
    
    func handleWalking() {
        let isMoving = abs(joystickDirection.dx) > 0.1
        // Flip direction immediately based on dx
        if isMoving {
            let newScale: CGFloat = joystickDirection.dx > 0 ? 1 : -1
            if player.xScale != newScale {
                player.xScale = newScale
            }
        }
        if isMoving && player.action(forKey: "run") == nil {
            player.removeAction(forKey: "idle")
            let run1 = SKAction.animate(with: runFrames1, timePerFrame: 0.1)
            let run2 = SKAction.animate(with: runFrames2, timePerFrame: 0.1)
            let sequence = SKAction.sequence([run1, audioFootstep, run2, audioFootstep])
            let runSequence = SKAction.repeatForever(sequence)
            player.run(runSequence, withKey: "run")
            player.xScale = joystickDirection.dx > 0 ? 1 : -1
        } else if !isMoving {
            player.removeAction(forKey: "run")
            let walkAction = SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: 0.3))
            player.run(walkAction, withKey: "idle")
        }
    }
    
    func setupPlayer() {
        guard let spawn = spawnPoint else {
            print("⚠️ Spawn point not set. Aborting player setup.")
            return
        }
        
        let textureAtlas = SKTextureAtlas(named: "Player-Idle")
        idleFrames = (0...2).map { textureAtlas.textureNamed("adventurer-idle-0\($0)") }
        let textureAtlas2 = SKTextureAtlas(named: "Player-Run")
        runFrames1 = (0...2).map { textureAtlas2.textureNamed("adventurer-run-0\($0)") }
        runFrames2 = (3...5).map { textureAtlas2.textureNamed("adventurer-run-0\($0)") }
        audioFootstep = SKAction.playSoundFileNamed("Player_Walk.wav", waitForCompletion: false)
        
        player = SKSpriteNode(texture: idleFrames[0])
        player.position = spawnPoint!
        player.zPosition = 1
//        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.size = CGSize(width: 51*2, height: 37*2)
        
        // Physics
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 51*2, height: 37*2))
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.ground
        player.physicsBody?.collisionBitMask = PhysicsCategory.ground
        player.physicsBody?.allowsRotation = false
        
        
        player.name = "player"
        addChild(player)
        
        let walkAction = SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: 0.3))
        player.run(walkAction, withKey: "idle")
    }
    
    func setupCameraPlayer() {
        guard let cameraNode = self.childNode(withName: "//SKCameraNode") as? SKCameraNode else {
            print("⚠️ Camera node not found")
            return
        }
        
        self.camera = cameraNode // Assign camera to scene
    }
    
    func setupNpc() {
        if let npcNode = self.childNode(withName: "//npc_smith") as? SKSpriteNode {
            npcNode.name = "npc_smith"
            npcNode.size = CGSize(width: 100, height: 74)
            npcNode.zPosition = 0
            npcNode.physicsBody = SKPhysicsBody(rectangleOf: npcNode.size)
            npcNode.physicsBody?.categoryBitMask = PhysicsCategory.npc
            npcNode.physicsBody?.contactTestBitMask = PhysicsCategory.player
            npcNode.physicsBody?.collisionBitMask = PhysicsCategory.ground
            npcNode.physicsBody?.isDynamic = true
            npcNode.physicsBody?.affectedByGravity = true
        }
    }
    
    func loadTileMap() {
        guard let tileMap = childNode(withName: "//tileMap") as? SKTileMapNode else {
            print("⚠️ Tile map node named 'tileMap' not found in scene.")
            return
        }
        
        // Optional: Ensure it's rendered in the correct layer order
        tileMap.zPosition = 1
        
        print("✅ Tile map loaded successfully.")
    }
    
    func setupDialogSystem() {
        dialogSystem.setPlayerPortraits(playerPortrait)
        dialogSystem.registerDialogTree(npcSmith)

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
//        #if os(iOS)
        virtualController?.disconnect()
//        #endif
    }
}
