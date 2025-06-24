//
//  PlayingState.swift
//  TestGame
//
//  Created by Steven Gonawan on 19/06/25.
//
import GameplayKit
import GameController

class PlayingState: GameState {
    private var joystickDirection = CGVector.zero
    private var timeElapsed: TimeInterval = 0
    let maxInteractionDistance: CGFloat = 150
    
    override func didEnter(from previousState: GKState?) {
        print("PlayingState")
        scene.visNovNode.isHidden = true
        setupController()
    }
    
    private func setupController() {
        if scene.virtualController != nil { return }

        let config = GCVirtualController.Configuration()
        config.elements = [GCInputLeftThumbstick, GCInputButtonA]

        let controller = GCVirtualController(configuration: config)
        scene.virtualController = controller
        controller.connect()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self,
                  let gamepad = self.scene.virtualController?.controller?.extendedGamepad else { return }
            let scene = self.scene

            gamepad.leftThumbstick.valueChangedHandler = { _, x, _ in
                self.joystickDirection = CGVector(dx: CGFloat(x), dy: 0)
            }

            gamepad.buttonA.pressedChangedHandler = { _, _, pressed in
                guard pressed else { return }
                
                if scene.isNearGate {
                    if let wispAmount = scene.playerEntity.component(ofType: WispPointComponent.self)?.getBlueWisp(), wispAmount > 1 {
                        // ✅ Disable controller before triggering the interaction
                        gamepad.valueChangedHandler = nil
                        gamepad.leftThumbstick.valueChangedHandler = nil
                        gamepad.buttonA.pressedChangedHandler = nil
                        gamepad.buttonB.pressedChangedHandler = nil
                        scene.virtualController?.controller?.extendedGamepad?.valueChangedHandler = nil
                        scene.virtualController?.disconnect()
                        scene.virtualController = nil

                        // Clear reference entirely (optional but helps)
                        scene.virtualController = nil

                        scene.handleGateInteraction()
                    } else {
                        scene.handleGateInteraction()
                    }
                }
                self.tryStartNpcDialog()
            }
        }
    }

    
    override func update(deltaTime seconds: TimeInterval) {
        if scene.visNovNode.isHidden == false {
            joystickDirection = .zero
            if let movement = scene.playerEntity.component(ofType: MovementComponent.self) {
                movement.setDirection(.zero)
            }
        } else {
            if let movement = scene.playerEntity.component(ofType: MovementComponent.self) {
                movement.setDirection(joystickDirection)
            }
        }
        
        if let cameraNode = scene.camera {
            let buttonName = "pauseButton"
            if cameraNode.childNode(withName: buttonName) == nil {
                let texture = SKTexture(imageNamed: "GearIcon")
                texture.filteringMode = .nearest
                let pauseButton = SKSpriteNode(texture: texture, size: CGSize(width: 80, height: 80))
                pauseButton.name = buttonName
                pauseButton.zPosition = 50
                cameraNode.addChild(pauseButton)

                pauseButton.position = CGPoint(
                    x: UIScreen.main.bounds.width * -0.6 - 80,
                    y: UIScreen.main.bounds.height * 0.4 + 80,
                )
            }
        }

        scene.playerEntity.update(deltaTime: seconds)

        guard let camera = scene.camera,
              let playerNode = scene.playerEntity.component(ofType: RenderComponent.self)?.node else { return }

        camera.position = CGPoint(x: playerNode.position.x, y: playerNode.position.y + 150)

        let dx = joystickDirection.dx
        let px = playerNode.position.x

        scene.backgroundBg.update(playerX: px, direction: dx, speed: 0.02)
        scene.farthestBg.update(playerX: px, direction: dx, speed: 0.04)
        scene.farBg.update(playerX: px, direction: dx, speed: 0.07)
        scene.effectBg.update(playerX: px, direction: dx, speed: 0.07)
        scene.midBg.update(playerX: px, direction: dx, speed: 0.1)
        scene.nearestBg.update(playerX: px, direction: dx, speed: 0.0)
        
        tryCollectNearbyHerb()
    }
    
    func tryStartNpcDialog() {
        guard let playerNode = scene.playerEntity.component(ofType: RenderComponent.self)?.node else {
            print("Player node not found.")
            return
        }

        // Find all NPC nodes
        let npcNodes = scene.children.compactMap { node -> SKNode? in
            guard let name = node.name, name.starts(with: "npc_") else { return nil }
            return node
        }

        // Filter by distance
        let nearbyNpcs = npcNodes.filter {
            $0.position.distance(to: playerNode.position) <= maxInteractionDistance
        }

        guard let nearestNpc = nearbyNpcs.min(by: {
            $0.position.distance(to: playerNode.position) < $1.position.distance(to: playerNode.position)
        }) else {
            print("No nearby NPC found within range.")
            return
        }
        
        let npcId = nearestNpc.name!
        
        guard let npcTree = scene.dialogSystem.getDialogTree(for: npcId) else {
            print("NPC dialog tree not found for: \(npcId)")
            return
        }

        guard let progress = GameManager.shared.playerEntity?.component(ofType: DialogProgressComponent.self) else {
            print("DialogProgressComponent not found.")
            return
        }
        
        
        let allStates = npcTree.dialogs.keys
                .filter { $0 != "default" }
                .sorted()
        
        let uncompletedState = allStates.first { !progress.hasCompletedDialog("\($0)") }
        
        let selectedState = uncompletedState ?? "default"
        
        print("Starting dialog with NPC: \(npcId), state: \(selectedState)")
        stateMachine?.enter(DialogState.self)
        scene.dialogSystem.startDialog(npcId: npcId, state: selectedState)
    }
    
    func tryCollectNearbyHerb() {
        guard let herb = scene.nearbyHerbNode,
        let gamepad = scene.virtualController?.controller?.extendedGamepad,
        gamepad.buttonA.isPressed else {
            return
        }

        // Prevent collecting the same herb again
        scene.nearbyHerbNode = nil

        // Remove from scene
        herb.removeFromParent()

        // Add to inventory
        GameManager.shared.playerEntity?.component(ofType: InventoryComponent.self)?.addItem("Herb", count: 1)

        print("✅ Collected herb: \(herb.name ?? "?")")
    }

    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == DialogState.self || stateClass == PauseState.self
    }
}
