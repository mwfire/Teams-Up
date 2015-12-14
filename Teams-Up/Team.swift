//
//  Teams.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 11/28/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import Foundation

class Team {
    
    let name: String
    var players: [Player]
    var totalRating: Double {
        let total = players.reduce(0) { (subTotal, player) -> Double in
            subTotal + player.rating
        }
        return total
    }
    var averageRating: Double {
        guard !players.isEmpty else {
            return 0.0
        }
        return totalRating / Double(players.count)
    }
    
    init(name: String, players: [Player]) {
        self.name = name
        self.players = players
    }
    
    convenience init(name: String) {
        self.init(name: name, players: [Player]())
    }
}