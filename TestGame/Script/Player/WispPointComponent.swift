//
//  WispPointComponent.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 17/06/25.
//

import GameplayKit

class WispPointComponent: GKComponent {
    var wispBlue: Int = 0
    var wispRed: Int = 0
    
    var alignment: String {
        if wispBlue > wispRed {
            return "Good"
        } else if wispRed > wispBlue {
            return "Bad"
        } else {
            return "Neutral"
        }
    }
    
    func addWispBlue() {
        wispBlue += 1
    }
    
    func addWispRed() {
        wispRed += 1
    }
    
    func getBlueWisp() -> Int {
        return self.wispBlue
    }
}

extension WispPointComponent: DialogPlaceholderProvider {
    func providePlaceholders() -> [String: String] {
        return [
            "{wispRed}": "\(wispRed)",
            "{wispBlue}": "\(wispBlue)",
            "{alignment}": "\(alignment)",
        ]
    }
}
