//
//  PlayingState.swift
//  TestGame
//
//  Created by Steven Gonawan on 19/06/25.
//
import GameplayKit
import GameController

class PlayingState: GameState {
    // Track movement input (add this property)
    private var joystickDirection = CGVector.zero
    private var timeElapsed: TimeInterval = 0
    
    override func didEnter(from previousState: GKState?) {
        scene.visNovNode.isHidden = true
        setupController()
    }
    
    // MARK: - Input Handling (New)
    private func setupController() {
        // Prevent duplicate controller creation
        if scene.virtualController != nil { return }

        let config = GCVirtualController.Configuration()
        config.elements = [GCInputLeftThumbstick, GCInputButtonA, GCInputButtonB]

        let controller = GCVirtualController(configuration: config)
        scene.virtualController = controller
        controller.connect()

        // Wait for controller to become available (asynchronously)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self,
                  let gamepad = self.scene.virtualController?.controller?.extendedGamepad else { return }

            // 🎮 Joystick handler (left-right movement only)
            gamepad.leftThumbstick.valueChangedHandler = { _, x, _ in
                self.joystickDirection = CGVector(dx: CGFloat(x), dy: 0)
            }

            // 🅰️ Button A handler (start dialog)
            gamepad.buttonA.pressedChangedHandler = { _, _, pressed in
                guard pressed else { return }

                self.tryStartNpcDialog()
            }
        }
    }

    
    // MARK: - Movement Update (New)
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

        scene.playerEntity.update(deltaTime: seconds)

        guard let camera = scene.camera,
              let playerNode = scene.playerEntity.component(ofType: RenderComponent.self)?.node else { return }

        camera.position = CGPoint(x: playerNode.position.x, y: playerNode.position.y + 150)

        // Parallax update
        let dx = joystickDirection.dx
        let px = playerNode.position.x

        scene.backgroundBg.update(playerX: px, direction: dx, speed: 0.02)
        scene.farthestBg.update(playerX: px, direction: dx, speed: 0.04)
        scene.farBg.update(playerX: px, direction: dx, speed: 0.07)
        scene.effectBg.update(playerX: px, direction: dx, speed: 0.07)
        scene.midBg.update(playerX: px, direction: dx, speed: 0.1)
        scene.nearestBg.update(playerX: px, direction: dx, speed: 0.0)
    }
    
    // MARK: - StartNPCDialog
    func tryStartNpcDialog() {
        guard let npcId = scene.contactedNpcId else {
            print("No NPC contact detected.")
            return
        }

        print("Starting dialog with NPC: \(npcId)")
        stateMachine?.enter(DialogState.self)
        scene.dialogSystem.startDialog(npcId: npcId, state: "quest_01")
    }


    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == DialogState.self
    }
}
