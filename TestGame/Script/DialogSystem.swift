//
//  DialogSystem.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 10/06/25.
//

import SpriteKit

struct DialogLine {
    let text: String
    let speaker: String
    let expression: String?

    // Cutscene overlay options
    let overlayAlpha: CGFloat?
    let overlayTexture: String?
    let overlayColor: SKColor? 
}

struct DialogChoice {
    let text: String
    let action: (() -> Void)?
    let requiredItems: [String: Int]?
    let followUpDialog: [DialogLine]?
    let followUpChoices: [DialogChoice]?
}

struct NpcData {
    let name: String
    let portraits: [String: String] // expression: image name
    let bubbleTextureName: String?
    let textColor: SKColor?
    let dialogSequence: [DialogLine]
    let choices: [DialogChoice]?
}

struct NpcDialogTree {
    let npcId: String
    var dialogs: [String: NpcData] // condition or tag: dialog
}

class DialogSystem {
    
    private var npcDialogDatabase: [String: NpcDialogTree] = [:]
    private var currentDialogSequence: [DialogLine] = []
    private var currentDialogIndex: Int = 0
    private var currentChoices: [DialogChoice]? = nil
    private var currentNpc: NpcData?
    private var playerPortraits: [String: String] = [:]
    var resolver: PlaceholderResolver?

    var onDialogLineDisplayed: ((DialogLine, String?, String?, SKColor?) -> Void)?
    var onDialogEnded: (() -> Void)?
    var onChoicesPresented: (([DialogChoice]) -> Void)?

    func setPlayerPortraits(_ portraits: [String: String]) {
        playerPortraits = portraits
    }

    func registerDialogTree(_ tree: NpcDialogTree) {
        npcDialogDatabase[tree.npcId] = tree
    }

    func startDialog(npcId: String, state: String = "default") {
        guard let npcTree = npcDialogDatabase[npcId],
              let npc = npcTree.dialogs[state] else {
            print("Dialog not found for NPC: \(npcId), state: \(state)")
            return
        }
        
        self.resolver = PlaceholderResolver(from: GameManager.shared.playerEntity!)
        currentNpc = npc
        currentDialogSequence = npc.dialogSequence
        currentDialogIndex = 0
        currentChoices = npc.choices
        showNextDialogLine()
    }

    func showNextDialogLine() {
        guard let npc = currentNpc else { return }

        if currentDialogIndex < currentDialogSequence.count {
            let line = currentDialogSequence[currentDialogIndex]
            let resolvedLine = DialogLine(
                text: resolver?.resolve(text: line.text) ?? line.text,
                speaker: resolver?.resolve(text: line.speaker) ?? line.speaker,
                expression: line.expression,
                overlayAlpha: line.overlayAlpha,
                overlayTexture: line.overlayTexture,
                overlayColor: line.overlayColor
            )
            var currentBubbleTextureName: String?
            if resolvedLine.speaker == npc.name {
                currentBubbleTextureName = npc.bubbleTextureName
            } else{
                currentBubbleTextureName = nil
            }
            let portraitImageName = (line.speaker == npc.name
                                      ? npc.portraits[line.expression ?? ""]
                                      : playerPortraits[line.expression ?? ""])
            onDialogLineDisplayed?(resolvedLine, portraitImageName, currentBubbleTextureName, npc.textColor)
            currentDialogIndex += 1
        } else {
            print("Reached end of dialog lines.")
            print("Choices count: \(currentChoices?.count ?? -1)")
            if let choices = currentChoices, !choices.isEmpty {
                onChoicesPresented?(choices)
            } else {
                endDialog()
            }
        }
    }

    func selectChoice(_ choice: DialogChoice) {
        choice.action?()
        if let followUp = choice.followUpDialog {
            currentDialogSequence = followUp
            currentDialogIndex = 0
            currentChoices = choice.followUpChoices
            showNextDialogLine()
        } else {
            endDialog()
        }
    }

    func endDialog() {
        print("dialog ended")
        onDialogEnded?()
        currentDialogSequence = []
        currentDialogIndex = 0
        currentChoices = nil
        currentNpc = nil
        resolver = nil

        onDialogLineDisplayed = nil
        onDialogEnded = nil
        onChoicesPresented = nil
    }
    
    func getDialogTree(for npcId: String) -> NpcDialogTree? {
        return npcDialogDatabase[npcId]
    }
}
