//
//  DialogData.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 10/06/25.
//

let playerPortrait: [String: String] = [
    "neutral" : "MCVN",
    "angry" : "MCVN",
    "sad" : "MCVN",
    "happy" : "MCVN",
]

let npcGuardian = NpcDialogTree(
    npcId: "npc_guardian",
    dialogs: [
        "default" : NpcData(
            name: "Guardian",
            portraits: [
                "neutral" : "GatekeeperVN",
                "angry" : "GatekeeperVN",
                "sad" : "GatekeeperVN",
                "happy" : "GatekeeperVN"
            ],
            bubbleTextureName: "bubble-guardian",
            textColor: .white,
            dialogSequence: [
                DialogLine(text: "Hello there, {playerName}", speaker: "Guardian", expression: "happy"),
                DialogLine(text: "What can I do for you?", speaker: "Guardian", expression: "neutral")
            ],
            choices: [
                DialogChoice(text: "I want to buy some weapons.",
                             action: nil,
                             followUpDialog: [
                                DialogLine(text: "I want to buy some weapons.", speaker: "{playerName}", expression: "neutral"),
                                DialogLine(text: "I'm sorry, I don't have any weapons for sale right now.", speaker: "Guardian", expression: "sad"),
                                DialogLine(text: "Come back later.", speaker: "Guardian", expression: "neutral"),
                             ],
                             followUpChoices: nil),
                DialogChoice(text: "I want to upgrade my current weapon.",
                             action: nil,
                             followUpDialog: [
                                DialogLine(text: "I want to upgrade my current weapon.", speaker: "{playerName}", expression: "neutral"),
                                DialogLine(text: "I'm sorry, I don't have any materials to upgrade your weapon right now.", speaker: "Guardian", expression: "sad"),
                                DialogLine(text: "Come back later.", speaker: "Guardian", expression: "neutral"),
                             ],
                             followUpChoices: nil),
                DialogChoice(text: "Later.",
                             action: nil,
                             followUpDialog: [
                                DialogLine(text: "Later.", speaker: "{playerName}", expression: "neutral"),
                                DialogLine(text: "Come back if you need help.", speaker: "Guardian", expression: "neutral")
                             ],
                             followUpChoices: nil)
            ]
        ),
        "quest_01" : NpcData(
            name: "Guardian",
            portraits: [
                "neutral" : "GatekeeperVN",
                "angry" : "GatekeeperVN",
                "sad" : "GatekeeperVN",
                "happy" : "GatekeeperVN"
            ],
            bubbleTextureName: "bubble-guardian",
            textColor: .white,
            dialogSequence: [
                DialogLine(text: "Hello there, {playerName}", speaker: "Guardian", expression: "happy"),
                DialogLine(text: "What can I do for you?", speaker: "Guardian", expression: "neutral")
            ],
            choices: [
                DialogChoice(text: "Actually, I heard that you need some help with something.",
                             action: nil,
                             followUpDialog: [
                                DialogLine(text: "Actually, I heard that you need some help with something.", speaker: "{playerName}", expression: "neutral"),
                                DialogLine(text: "Can you tell me more about it?", speaker: "{playerName}", expression: "neutral"),
                                DialogLine(text: "Ah, about that, huh?", speaker: "Guardian", expression: "neutral"),
                                DialogLine(text: "About 2 days ago, my daughter was playing with her friends.", speaker: "Guardian", expression: "neutral"),
                                DialogLine(text: "But, at noon, only her friends come back to the village.", speaker: "Guardian", expression: "neutral"),
                                DialogLine(text: "They say that my daughter help them to distract some monster in forest.", speaker: "Guardian", expression: "sad"),
                                DialogLine(text: "I know that she has her mother trait's, but i can't help but worry about her because she didn't go back to home.", speaker: "Guardian", expression: "sad"),
                                DialogLine(text: "Can you help me to find her?, I really need your help. Of course, you can take a reward if you find her.", speaker: "Guardian", expression: "sad"),
                             ],
                             followUpChoices: [
                                DialogChoice(text: "Of course, I can help you!",
                                             action: nil,
                                             followUpDialog: [
                                                DialogLine(text: "Of course, I can help you!", speaker: "{playerName}", expression: "neutral"),
                                                DialogLine(text: "Do you know which way the kids come back from forest?", speaker: "{playerName}", expression: "neutral"),
                                                DialogLine(text: "Ah, yes, it's north from here.", speaker: "Guardian", expression: "neutral"),
                                                DialogLine(text: "You will see a path with big trees on the left side.", speaker: "Guardian", expression: "neutral"),
                                                DialogLine(text: "I see. Thank you for the information.", speaker: "{playerName}", expression: "neutral"),
                                                DialogLine(text: "I will be back as soon as I can.", speaker: "{playerName}", expression: "neutral"),
                                             ],
                                             followUpChoices: nil),
                                DialogChoice(text: "I'm sorry, I can't help you.",
                                             action: nil,
                                             followUpDialog: [
                                                DialogLine(text: "I'm sorry, I can't help you.", speaker: "{playerName}", expression: "neutral"),
                                                DialogLine(text: "I understand.", speaker: "Guardian", expression: "neutral")
                                             ],
                                            followUpChoices: nil
                                            )
                             ]
                            ),
                DialogChoice(text: "Later.",
                             action: nil,
                             followUpDialog: [
                                DialogLine(text: "Later.", speaker: "{playerName}", expression: "neutral"),
                                DialogLine(text: "Come back if you need help.", speaker: "Guardian", expression: "happy")
                             ],
                             followUpChoices: nil)
            ]
        )
    ]
)
