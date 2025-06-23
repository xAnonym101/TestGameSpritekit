//
//  QuestsList.swift
//  TestGame
//
//  Created by Steven Gonawan on 20/06/25.
//

//let allQuests: [Quest] = [
//    guardianQuest,
//    dummy1,
//    dummy2,
//    dummy3
//]
//
//let guardianQuest = Quest(
//    name: "Find the Lumberjac",
//    description: "Help the guardian to find the lumberjack",
//    requiredItem: [:],
//    isStarted: false,
//    isActive: false,
//    isCompleted: false
//)
//
//let dummy1 = Quest(
//    name: "Dummy-1",
//    description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem!",
//    requiredItem: [:],
//    isStarted: false,
//    isActive: false,
//    isCompleted: false
//)
//
//let dummy2 = Quest(
//    name: "Dummy-2",
//    description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem!",
//    requiredItem: [:],
//    isStarted: false,
//    isActive: false,
//    isCompleted: false
//)
//
//let dummy3 = Quest(
//    name: "Dummy-3",
//    description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem!",
//    requiredItem: [:],
//    isStarted: false,
//    isActive: false,
//    isCompleted: false
//)

let allQuests: [String: Quest] = [
    "Find the Lumberjack": Quest(
        name: "Find the Lumberjack",
        description: "Help the guardian to find the lumberjack",
        requiredItem: [:],
        isStarted: false,
        isActive: false,
        isCompleted: false
    ),
    
    "Herb for the Lumberjack": Quest(
        name: "Herb for the Lumberjack",
        description: "Collect 3 soothing herbs for the lumberjack.",
        requiredItem: ["Herbs": 3],
        isStarted: false,
        isActive: false,
        isCompleted: false
    )
]
