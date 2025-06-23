//
//  DialogProgressComponent.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 22/06/25.
//

import GameplayKit

class DialogProgressComponent: GKComponent {
    private(set) var completedDialogs: Set<String> = []

    func markDialogCompleted(_ dialogId: String) {
        completedDialogs.insert(dialogId)
    }

    func hasCompletedDialog(_ dialogId: String) -> Bool {
        print(#function, dialogId)
        return completedDialogs.contains(dialogId)
    }
}
