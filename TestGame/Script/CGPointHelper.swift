//
//  CGPointHelper.swift
//  TestGame
//
//  Created by Syamsuddin Putra Riefli on 23/06/25.
//

import CoreGraphics

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let dx = x - point.x
        let dy = y - point.y
        return sqrt(dx * dx + dy * dy)
    }
}
