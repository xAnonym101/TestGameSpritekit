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
                             requiredItems: [
                                :
                             ],
                             followUpDialog: [
                                DialogLine(text: "I want to buy some weapons.", speaker: "{playerName}", expression: "neutral"),
                                DialogLine(text: "I'm sorry, I don't have any weapons for sale right now.", speaker: "Guardian", expression: "sad"),
                                DialogLine(text: "Come back later.", speaker: "Guardian", expression: "neutral"),
                             ],
                             followUpChoices: nil),
                DialogChoice(text: "I want to upgrade my current weapon.",
                             action: nil,
                             requiredItems: [
                                :
                             ],
                             followUpDialog: [
                                DialogLine(text: "I want to upgrade my current weapon.", speaker: "{playerName}", expression: "neutral"),
                                DialogLine(text: "I'm sorry, I don't have any materials to upgrade your weapon right now.", speaker: "Guardian", expression: "sad"),
                                DialogLine(text: "Come back later.", speaker: "Guardian", expression: "neutral"),
                             ],
                             followUpChoices: nil),
                DialogChoice(text: "Later.",
                             action: nil,
                             requiredItems: [
                                :
                             ],
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
                             requiredItems: [
                                :
                             ],
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
                                             action: {
                                                 GameManager.shared.playerEntity?.component(ofType: DialogProgressComponent.self)?.markDialogCompleted("npc_guardian_quest_01")
                                                 GameManager.shared.playerEntity?.component(ofType: QuestComponent.self)?.startQuest(named: "Find the Lumberjack")
                                                 
                                             },
                                             requiredItems: [
                                                :
                                             ],
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
                                             requiredItems: [
                                                :
                                             ],
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
                             requiredItems: [
                                :
                             ],
                             followUpDialog: [
                                DialogLine(text: "Later.", speaker: "{playerName}", expression: "neutral"),
                                DialogLine(text: "Come back if you need help.", speaker: "Guardian", expression: "happy")
                             ],
                             followUpChoices: nil)
            ]
        )
    ]
)

let npcLumberjack = NpcDialogTree(
    npcId: "npc_lumberjack",
    dialogs: [
        // Minimal default to avoid triggering quest accidentally
        "default": NpcData(
            name: "Lumberjack",
            portraits: [
                "neutral": "LumberjackVN",
                "happy": "LumberjackVN",
                "sad": "LumberjackVN"
            ],
            bubbleTextureName: "bubble-lumberjack",
            textColor: .white,
            dialogSequence: [
                DialogLine(text: "Hey there.", speaker: "Lumberjack", expression: "neutral")
            ],
            choices: [
                DialogChoice(
                    text: "How are you?",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "How are you?", speaker: "{playerName}", expression: "neutral"),
                        DialogLine(text: "Tired, as always...", speaker: "Lumberjack", expression: "sad")
                    ],
                    followUpChoices: nil
                )
            ]
        ),

        "01_lumberjack_quest_offer": NpcData(
            name: "Lumberjack",
            portraits: [
                "neutral": "LumberjackVN",
                "happy": "LumberjackVN",
                "sad": "LumberjackVN"
            ],
            bubbleTextureName: "bubble-lumberjack",
            textColor: .white,
            dialogSequence: [
                DialogLine(text: "Ah, my muscles ache from all the chopping.", speaker: "Lumberjack", expression: "sad"),
                DialogLine(text: "If only I had some herbs to ease the pain...", speaker: "Lumberjack", expression: "neutral")
            ],
            choices: [
                DialogChoice(
                    text: "Want me to find some herbs for you?",
                    action: {
                        GameManager.shared.playerEntity?.component(ofType: DialogProgressComponent.self)?.markDialogCompleted("01_lumberjack_quest_offer")
                        GameManager.shared.playerEntity?.component(ofType: QuestComponent.self)?.startQuest(named: "Herb for the Lumberjack")
                    },
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "Want me to find some herbs for you?", speaker: "{playerName}", expression: "neutral"),
                        DialogLine(text: "Really? That would be a great help!", speaker: "Lumberjack", expression: "happy")
                    ],
                    followUpChoices: nil
                ),
                DialogChoice(
                    text: "Maybe later.",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "Maybe later.", speaker: "{playerName}", expression: "neutral"),
                        DialogLine(text: "Alright, take care out there.", speaker: "Lumberjack", expression: "neutral")
                    ],
                    followUpChoices: nil
                )
            ]
        ),

        "02_lumberjack_herb_return": NpcData(
            name: "Lumberjack",
            portraits: [
                "neutral": "LumberjackVN",
                "happy": "LumberjackVN",
                "sad": "LumberjackVN"
            ],
            bubbleTextureName: "bubble-lumberjack",
            textColor: .white,
            dialogSequence: [
                DialogLine(text: "You're back! Did you find any herbs?", speaker: "Lumberjack", expression: "neutral")
            ],
            choices: [
                DialogChoice(
                    text: "Here are the herbs.",
                    action: {
                        GameManager.shared.playerEntity?.component(ofType: InventoryComponent.self)?.removeItem("Herb", count: 3)
                        GameManager.shared.playerEntity?.component(ofType: QuestComponent.self)?.completeQuest(named: "Herb for the Lumberjack")
                        GameManager.shared.playerEntity?.component(ofType: QuestComponent.self)?.completeQuest(named: "Find the Lumberjack")
                        GameManager.shared.playerEntity?.component(ofType: DialogProgressComponent.self)?.markDialogCompleted("02_lumberjack_herb_return")
                        GameManager.shared.playerEntity?.component(ofType: WispPointComponent.self)?.addWispBlue()
                    },
                    requiredItems: ["Herb": 3],
                    followUpDialog: [
                        DialogLine(text: "Here are the herbs.", speaker: "{playerName}", expression: "neutral"),
                        DialogLine(text: "Ah... I can feel the relief already, thank you.", speaker: "Lumberjack", expression: "happy"),
                        DialogLine(text: "Oh, by the way, I found this strange blue wisp earlier.", speaker: "Lumberjack", expression: "neutral"),
                        DialogLine(text: "It seems to resonate with you. Why don't you take it?", speaker: "Lumberjack", expression: "happy"),
                        DialogLine(text: "You received the Blue Wisp.", speaker: "{playerName}", expression: "neutral"),
                        DialogLine(text: "(You feel something change within you...)", speaker: "Narrator", expression: "neutral")
                    ],
                    followUpChoices: nil
                ),
                DialogChoice(
                    text: "Not yet...",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "Not yet...", speaker: "{playerName}", expression: "neutral"),
                        DialogLine(text: "That's alright. Let me know if you find any.", speaker: "Lumberjack", expression: "neutral")
                    ],
                    followUpChoices: nil
                )
            ]
        )
    ]
)



