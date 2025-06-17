//
//  GameScene.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 04/06/25.
//

import SpriteKit
//import GameplayKit
import GameController


class GameScene: SKScene {
    
//    var entities = [GKEntity]()
//    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var ground: SKNode?
    private var player: SKSpriteNode!
    private var spawnPoint: CGPoint?
    private var cameraPlayer: SKCameraNode?
    private var virtualController: GCVirtualController?
    var runFrames1: [SKTexture] = []
    var runFrames2: [SKTexture] = []
    var idleFrames: [SKTexture] = []
    var audioFootstep: SKAction!
    var joystickDirection = CGVector.zero
    
//    var backgroundContainer = SKNode()
//    var backgroundImageName = "forest-2"
//    var backgroundImageScaler: CGFloat = 2.9
    var foregroundLayer: BackgroundLayer!
    var midLayer: BackgroundLayer!
    var backLayer: BackgroundLayer!
    
    
    override func sceneDidLoad() {
        
        print("GameScene loaded")
        
        self.lastUpdateTime = 0
        
        setupSpawnPoint()
//        setupGround()
        setupPlayer()
        setupCameraPlayer()
        setupControllerHandlers()
        setupNpc()
        loadTileMap()
//        if let tileMap = self.childNode(withName: "GroundTileMap") as? SKTileMapNode {
//            setupPhysicsForTileMap(tileMap: tileMap, targetTileName: "grass-tile", physicsCategory: PhysicsCategory.ground)
//        }

    }
    
    
    override func didMove(to view: SKView) {
<<<<<<< Updated upstream
        
=======
        visNovNode.position = CGPoint(
            x: frame.midX,
            y: frame.minY
        )
        visNovNode.scene?.size = self.size
        self.camera?.addChild(visNovNode)
        visNovNode.resizeBackgroundNode(to: self.view!)
        visNovNode.isHidden = true
        setupDialogSystem()
        midLayer = BackgroundLayer(imageName: "forest-2", imageScaler: 2.3, zPos: -10, xPos: 1500, yPos: -430, scene: self, minTiles: 4, maxTiles: 5)
        foregroundLayer = BackgroundLayer(imageName: "forest-1", imageScaler: 3, zPos: -5, xPos: 1200, yPos: -740, scene: self, minTiles: 2, maxTiles: 3)
>>>>>>> Stashed changes
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
<<<<<<< Updated upstream
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        self.lastUpdateTime = currentTime
        
        let speed: CGFloat = 150
=======
>>>>>>> Stashed changes

        let dt = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime

        let baseSpeed: CGFloat = 200
        let dx = joystickDirection.dx * baseSpeed * CGFloat(dt)

        player.position.x += dx
<<<<<<< Updated upstream
        if let cameraPlayer = cameraPlayer, let player = player {
            cameraPlayer.position = player.position
=======
        self.camera?.position = CGPoint(x: player.position.x, y: player.position.y+100)

        if abs(dx) > 0.1 {
            foregroundLayer.update(playerX: player.position.x, direction: dx, speed: 0.0)
            midLayer.update(playerX: player.position.x, direction: dx, speed: 0.05)
>>>>>>> Stashed changes
        }
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
<<<<<<< Updated upstream
=======
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
    
    func setupKeyboardInput() {
        GCKeyboard.coalesced?.keyboardInput?.keyChangedHandler = { [weak self] _,_, keyCode, pressed in
            guard pressed else { return }

            switch keyCode {
            case .leftArrow:
                self?.joystickDirection = CGVector(dx: -1, dy: 0)
                self?.handleWalking()
            case .rightArrow:
                self?.joystickDirection = CGVector(dx: 1, dy: 0)
                self?.handleWalking()
            case .spacebar, .returnOrEnter:
                self?.tryStartNpcDialog()
            default:
                break
            }
        }
    }
    
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
>>>>>>> Stashed changes
        
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
            }
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
<<<<<<< Updated upstream
        player.size = CGSize(width: 90, height: 90)

        // Physics
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
=======
        player.size = CGSize(width: 51*2, height: 37*2)

        // Physics
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 51*2, height: 37*2))
>>>>>>> Stashed changes
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
        cameraPlayer = cameraNode
        self.camera = cameraNode // Assign camera to scene
    }
    
    func setupNpc() {
<<<<<<< Updated upstream
        if let npcNode = self.childNode(withName: "//npc1") as? SKSpriteNode {
            npcNode.name = "npc1"
            npcNode.size = CGSize(width: 90, height: 90)
=======
        if let npcNode = self.childNode(withName: "//npc_smith") as? SKSpriteNode {
            npcNode.name = "npc_smith"
            npcNode.size = CGSize(width: 100, height: 74)
>>>>>>> Stashed changes
            npcNode.zPosition = 0
            npcNode.physicsBody = SKPhysicsBody(rectangleOf: npcNode.size)
            npcNode.physicsBody?.categoryBitMask = PhysicsCategory.npc
            npcNode.physicsBody?.contactTestBitMask = PhysicsCategory.player
            npcNode.physicsBody?.collisionBitMask = PhysicsCategory.ground
            npcNode.physicsBody?.isDynamic = true
        }
    }
<<<<<<< Updated upstream
=======
    
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
    
    func loadTileMap() {
        guard let tileMap = childNode(withName: "//tileMap") as? SKTileMapNode else {
            print("⚠️ Tile map node named 'tileMap' not found in scene.")
            return
        }

        // Optional: Ensure it's rendered in the correct layer order
        tileMap.zPosition = 1

        print("✅ Tile map loaded successfully.")
    }
    
//    func setupPhysicsForTileMap(tileMap: SKTileMapNode, targetTileName: String, physicsCategory: UInt32) {
//        let tileSize = tileMap.tileSize
//        let mapWidth = CGFloat(tileMap.numberOfColumns) * tileSize.width
//        let mapHeight = CGFloat(tileMap.numberOfRows) * tileSize.height
//        let mapOrigin = CGPoint(x: -mapWidth / 2, y: -mapHeight / 2)
//
//        for row in 0..<tileMap.numberOfRows {
//            for column in 0..<tileMap.numberOfColumns {
//                guard let tileDefinition = tileMap.tileDefinition(atColumn: column, row: row),
//                      tileDefinition.name == targetTileName else {
//                    continue
//                }
//
//                let tileNode = SKNode()
//                let x = CGFloat(column) * tileSize.width + tileSize.width / 2 + mapOrigin.x
//                let y = CGFloat(row) * tileSize.height + tileSize.height / 2 + mapOrigin.y
//                tileNode.position = CGPoint(x: x, y: y)
//
//                tileNode.physicsBody = SKPhysicsBody(rectangleOf: tileSize)
//                tileNode.physicsBody?.isDynamic = false
//                tileNode.physicsBody?.categoryBitMask = physicsCategory
//                tileNode.physicsBody?.contactTestBitMask = PhysicsCategory.player
//                tileNode.physicsBody?.collisionBitMask = PhysicsCategory.player
//
//                tileMap.addChild(tileNode)
//            }
//        }
//    }



>>>>>>> Stashed changes
}
