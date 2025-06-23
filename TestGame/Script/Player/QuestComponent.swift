//
//  QuestComponent.swift
//  TestGame
//
//  Created by Steven Gonawan on 20/06/25.
//

import GameplayKit

enum QuestState {
    case notStarted, started, active, completed
}

struct Quest {
    let name: String
    let description: String
    let requiredItem: [String: Int]?
    var isStarted: Bool
    var isActive: Bool
    var isCompleted: Bool
}

class QuestComponent: GKComponent {
    
    private(set) var quests: [Quest] = []
    
    func addQuests(named name: String) {
        guard let quest = allQuests[name] else {
            print("❌ Quest with name '\(name)' not found in QuestDatabase.")
            return
        }

        guard !quests.contains(where: { $0.name == quest.name }) else {
            print("⚠️ Quest '\(quest.name)' already exists.")
            return
        }

        print("✅ Quest added: \(quest.name)")
        quests.append(quest)
    }

    
    func startQuest(named name: String) {
        addQuests(named: name)
        guard let index = quests.firstIndex(where: { $0.name == name }) else { return }
        var quest = quests[index]
        quest.isStarted = true
        quest.isActive = true
        quests[index] = quest
    }
    
    func completeQuest(named name: String) {
        guard let index = quests.firstIndex(where: { $0.name == name }) else { return }
        var quest = quests[index]
        quest.isActive = false
        quest.isCompleted = true
        quests[index] = quest
    }
    
    func isQuestActive(named name: String) -> Bool {
        return quests.first(where: { $0.name == name })?.isActive ?? false
    }
    
    func activeQuests() -> [Quest] {
        return quests.filter { $0.isActive }
    }
    
    func completedQuests() -> [Quest] {
        return quests.filter { $0.isCompleted }
    }
    
    func quest(named name: String) -> Quest? {
        return quests.first(where: { $0.name == name })
    }
    
    func debugPrintAllQuests() {
        for quest in quests {
            print("""
            ▶︎ Name: \(quest.name)
               Description: \(quest.description)
               Required Item: \(quest.requiredItem ?? [:])
               Started: \(quest.isStarted), Active: \(quest.isActive), Completed: \(quest.isCompleted)
            """)
        }
    }
}

