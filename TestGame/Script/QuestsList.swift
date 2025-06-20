//
//  QuestsList.swift
//  TestGame
//
//  Created by Steven Gonawan on 20/06/25.
//

let allQuests: [Quest] = [
    guardianQuest,
    dummy1,
    dummy2,
    dummy3
]

let guardianQuest = Quest(
    name: "Find the Guardian's Daughter",
    description: "Help the guardian find his missing daughter in the forest.",
    requiredItem: "Forest Map",
    isStarted: false,
    isActive: false,
    isCompleted: false
)

let dummy1 = Quest(
    name: "Dummy-1",
    description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem!",
    requiredItem: "",
    isStarted: false,
    isActive: false,
    isCompleted: false
)

let dummy2 = Quest(
    name: "Dummy-2",
    description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem!",
    requiredItem: "",
    isStarted: false,
    isActive: false,
    isCompleted: false
)

let dummy3 = Quest(
    name: "Dummy-3",
    description: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem!",
    requiredItem: "",
    isStarted: false,
    isActive: false,
    isCompleted: false
)
