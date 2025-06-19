//
//  DialogState.swift
//  TestGame
//
//  Created by Steven Gonawan on 19/06/25.
//
import GameplayKit

class DialogState: GameState {
    override func didEnter(from previousState: GKState?) {
        scene.visNovNode.isHidden = false
        scene.virtualController = nil // Disable input
        setupDialogSystem()
    }
    
    private func setupDialogSystem() {
            // Only setup if not already
            guard scene.dialogSystem.onDialogLineDisplayed == nil else { return }

            scene.dialogSystem.setPlayerPortraits(playerPortrait)
            scene.dialogSystem.registerDialogTree(npcGuardian)

            scene.dialogSystem.onDialogLineDisplayed = { [weak self] line, portrait in
                let texture = portrait != nil ? SKTexture(imageNamed: portrait!) : nil
                self?.scene.visNovNode.updateDialog(line: line, texture: texture)
            }

            scene.dialogSystem.onChoicesPresented = { [weak self] choices in
                self?.scene.visNovNode.showChoices(choices: choices) { index in
                    self?.scene.dialogSystem.selectChoice(choices[index])
                }
            }

            scene.dialogSystem.onDialogEnded = { [weak self] in
                self?.scene.stateMachine.enter(PlayingState.self)
                self?.scene.dialogSystem.onDialogEnded = nil
            }
        }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == PlayingState.self // Only allow transition back to PlayingState
    }
}
