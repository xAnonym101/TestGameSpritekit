//
//  InventoryComponent.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 17/06/25.
//

import GameplayKit

class InventoryComponent: GKComponent {
    private(set) var items: [String: Int] = [:]
    
    func addItem(_ item: String, count: Int = 1) {
        items[item, default: 0] += count
    }
    
    func removeItem(_ item: String, count: Int = 1) {
        guard let currentCount = items[item] else { return }
        let newCount = max(0, currentCount - count)
        if newCount == 0 {
            items.removeValue(forKey: item)
        }else{
            items[item] = newCount
        }
    }
    
    func itemCount(_ item: String) -> Int {
        return items[item] ?? 0
    }
    
    func hasItem(_ item: String, count: Int = 1) -> Bool {
        return itemCount(item) > 0
    }
}
