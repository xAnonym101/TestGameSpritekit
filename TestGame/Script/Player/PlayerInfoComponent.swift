//
//  PlayerInfoComponent.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 17/06/25.
//

import GameplayKit

class PlayerInfoComponent: GKComponent {
    var name: String
    var form: String
    
    init(name: String = "Nephyr", form: String = "lesser") {
        self.name = name
        self.form = form
        super.init()
    }
    
    func changePlayerName (newName: String) {
        self.name = newName
    }
    
    func changePlayerForm (newForm: String) {
        self.form = newForm
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlayerInfoComponent: DialogPlaceholderProvider {
    func providePlaceholders() -> [String: String] {
        return [
            "{playerName}": name
        ]
    }
}
