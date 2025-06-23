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
        "default": NpcData(
            name: "Guardian",
            portraits: [
                "neutral": "GatekeeperVN",
                "angry": "GatekeeperVN",
                "sad": "GatekeeperVN",
                "happy": "GatekeeperVN"
            ],
            bubbleTextureName: "bubble-guardian",
            textColor: .white,
            dialogSequence: [
                DialogLine(text: "Hello there, {playerName}", speaker: "Guardian", expression: "happy", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                DialogLine(text: "What can I do for you?", speaker: "Guardian", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
            ],
            choices: [
                DialogChoice(
                    text: "I want to buy some weapons.",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "I want to buy some weapons.", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "I'm sorry, I don't have any weapons for sale right now.", speaker: "Guardian", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Come back later.", speaker: "Guardian", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                    ],
                    followUpChoices: nil
                ),
                DialogChoice(
                    text: "I want to upgrade my current weapon.",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "I want to upgrade my current weapon.", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "I'm sorry, I don't have any materials to upgrade your weapon right now.", speaker: "Guardian", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Come back later.", speaker: "Guardian", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                    ],
                    followUpChoices: nil
                ),
                DialogChoice(
                    text: "Later.",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "Later.", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Come back if you need help.", speaker: "Guardian", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
                    ],
                    followUpChoices: nil
                )
            ]
        ),
        
        "quest_01": NpcData(
            name: "Guardian",
            portraits: [
                "neutral": "GatekeeperVN",
                "angry": "GatekeeperVN",
                "sad": "GatekeeperVN",
                "happy": "GatekeeperVN"
            ],
            bubbleTextureName: "bubble-guardian",
            textColor: .white,
            dialogSequence: [
                DialogLine(text: "Hello there, {playerName}", speaker: "Guardian", expression: "happy", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                DialogLine(text: "What can I do for you?", speaker: "Guardian", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
            ],
            choices: [
                DialogChoice(
                    text: "Actually, I heard that you need some help with something.",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "Actually, I heard that you need some help with something.", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Can you tell me more about it?", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Ah, yes. It's about the lumberjack who lives on the edge of the forest.", speaker: "Guardian", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "He's usually reliable, but he hasn’t returned to the village in two days.", speaker: "Guardian", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Some villagers said they heard strange noises coming from his area.", speaker: "Guardian", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "He might be injured… or worse. I’m worried something has happened to him.", speaker: "Guardian", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "I’d go myself, but I can’t leave the gate unguarded.", speaker: "Guardian", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Can you please check on him? If he’s okay, escort him back. If not… just report back to me.", speaker: "Guardian", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
                    ],
                    followUpChoices: [
                        DialogChoice(
                            text: "I'll find the lumberjack for you.",
                            action: {
                                GameManager.shared.playerEntity?.component(ofType: DialogProgressComponent.self)?.markDialogCompleted("npc_guardian_quest_01")
                                GameManager.shared.playerEntity?.component(ofType: QuestComponent.self)?.startQuest(named: "Find the Lumberjack")
                            },
                            requiredItems: [:],
                            followUpDialog: [
                                DialogLine(text: "I'll find the lumberjack for you.", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                                DialogLine(text: "Do you know where he was last seen?", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                                DialogLine(text: "North of here, past the big hollow tree. That’s where his cabin should be.", speaker: "Guardian", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                                DialogLine(text: "Got it. I’ll head there immediately.", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                            ],
                            followUpChoices: nil
                        ),
                        DialogChoice(
                            text: "Sorry, I'm not able to help right now.",
                            action: nil,
                            requiredItems: [:],
                            followUpDialog: [
                                DialogLine(text: "Sorry, I'm not able to help right now.", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                                DialogLine(text: "I understand. Stay safe, {playerName}.", speaker: "Guardian", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
                            ],
                            followUpChoices: nil
                        )
                    ]
                ),
                DialogChoice(
                    text: "Later.",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "Later.", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Come back if you need help.", speaker: "Guardian", expression: "happy", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
                    ],
                    followUpChoices: nil
                )
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
                DialogLine(text: "Hey there.", speaker: "Lumberjack", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
            ],
            choices: [
                DialogChoice(
                    text: "How are you?",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "How are you?", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Tired, as always...", speaker: "Lumberjack", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
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
                DialogLine(text: "Ah, my muscles ache from all the chopping.", speaker: "Lumberjack", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                DialogLine(text: "I've been doing this for years now, and nobody has ever helped me.", speaker: "Lumberjack", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                DialogLine(text: "The village just relies on me too much.", speaker: "Lumberjack", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                DialogLine(text: "Now I can't even come back home....", speaker: "Lumberjack", expression: "sad", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                DialogLine(text: "If only I had some herbs to ease the pain... Urgh*", speaker: "Lumberjack", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
            ],
            choices: [
                DialogChoice(
                    text: "Don't worry I'll get them for you",
                    action: {
                        GameManager.shared.playerEntity?.component(ofType: DialogProgressComponent.self)?.markDialogCompleted("01_lumberjack_quest_offer")
                        GameManager.shared.playerEntity?.component(ofType: QuestComponent.self)?.startQuest(named: "Herb for the Lumberjack")
                    },
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "Don't worry I'll get them for you", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Really? That would be a great help!", speaker: "Lumberjack", expression: "happy", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
                    ],
                    followUpChoices: nil
                ),
                DialogChoice(
                    text: "Maybe later.",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "Maybe later.", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Alright, take care out there.", speaker: "Lumberjack", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
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
                DialogLine(text: "You're back! Did you find any herbs?", speaker: "Lumberjack", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
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
                        DialogLine(text: "Here are the herbs.", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Ah... I can feel the relief already, thank you.", speaker: "Lumberjack", expression: "happy", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "Oh, by the way, I found this strange blue wisp earlier.", speaker: "Lumberjack", expression: "neutral", overlayAlpha: 1, overlayTexture: "CutScene1", overlayColor: .black),
                        DialogLine(text: "It seems to resonate with you. Why don't you take it?", speaker: "Lumberjack", expression: "happy", overlayAlpha: 1, overlayTexture: "CutScene1", overlayColor: .black),
                        DialogLine(text: "You received the Blue Wisp.", speaker: "{playerName}", expression: "neutral", overlayAlpha: 0.5, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "(You feel something change within you...)", speaker: "Narrator", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
                    ],
                    followUpChoices: nil
                ),
                DialogChoice(
                    text: "Not yet...",
                    action: nil,
                    requiredItems: [:],
                    followUpDialog: [
                        DialogLine(text: "Not yet...", speaker: "{playerName}", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black),
                        DialogLine(text: "That's alright. Let me know if you find any.", speaker: "Lumberjack", expression: "neutral", overlayAlpha: nil, overlayTexture: nil, overlayColor: .black)
                    ],
                    followUpChoices: nil
                )
            ]
        )
    ]
)
