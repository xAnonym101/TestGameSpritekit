////
////  QuestSystem.swift
////  TestGame
////
////  Created by Syamsuddin Putra Riefli on 21/06/25.
////
//
//import Foundation
//
//enum QuestStatus {
//    case notStarted, started, active, completed
//}
//
//struct Quest {
//    let name: String
//    let description: String
//    let requiredItem: [String: Int]?
//    var status: QuestStatus
//}
//
//class QuestSystem {
//    func addQuest(_ quest: Quest) {
//        guard !quests.contains(where: { $0.name == quest.name }) else {
//            print("⚠️ Quest \(quest.name) already exists.")
//            return
//        }
//        quests.append(quest)
//    }
//    
//    func startQuest(named name: String) {
//        guard let index = quests.firstIndex(where: { $0.name == name }) else { return }
//        var quest = quests[index]
//        quest.isStarted = true
//        quest.isActive = true
//        quests[index] = quest
//    }
//    
//    func completeQuest(named name: String) {
//        guard let index = quests.firstIndex(where: { $0.name == name }) else { return }
//        var quest = quests[index]
//        quest.isActive = false
//        quest.isCompleted = true
//        quests[index] = quest
//    }
//}
