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
    
    func removeItem(_ item: String, count: Int) {
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
    
    func hasItems(_ requiredItems: [String: Int]) -> Bool {
        for (item, count) in requiredItems {
            if itemCount(item) < count {
                return false
            }
        }
        return true
    }

    func missingItems(from requiredItems: [String: Int]) -> [String: Int] {
        var missing: [String: Int] = [:]

        for (item, count) in requiredItems {
            let owned = itemCount(item)
            if owned < count {
                missing[item] = count - owned
            }
        }

        return missing
    }
}

extension InventoryComponent: DialogPlaceholderProvider {
    func providePlaceholders() -> [String: String] {
        var placeholders: [String: String] = [:]

        for (item, count) in items {
            let key = item
                .lowercased()
                .replacingOccurrences(of: " ", with: "_")  // "Library 2 Key" → "library_2_key"
            placeholders["{\(key)}"] = "\(count)"
        }
        
        return placeholders
    }
}
