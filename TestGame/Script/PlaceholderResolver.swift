//
//  PlaceholderResolver.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 20/06/25.
//

import GameplayKit

class PlaceholderResolver {
    private var providers: [DialogPlaceholderProvider] = []
    
    init(from entity: GKEntity) {
        for component in entity.components {
            if let provider = component as? DialogPlaceholderProvider {
                providers.append(provider)
            }
        }
    }
    
    func resolve(text: String) -> String {
        var result = text
        for provider in providers {
            let replacements = provider.providePlaceholders()
            for (placeholder, value) in replacements {
                result = result.replacingOccurrences(of: placeholder, with: value)
            }
        }
        return result
    }
}
