//
//  PlayersDataSource.swift
//  Teams-Up
//
//  Created by Martin Wildfeuer on 08.12.15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import Foundation
import RealmSwift

struct PlayersDataSource {
    
    static private var realm = try! Realm()
    
    static var numberOfSections: Int {
        return 1
    }
    
    static var numberOfRows: Int {
        return players.count
    }
    
    static var players: Results<Player> {
        let players = realm.objects(Player)
        return players
    }
    
    static func playerForIndexPath(indexPath: NSIndexPath) -> Player? {
        if indexPath.row < players.count {
            return players[indexPath.row]
        }
        
        return nil
    }
    
    static func addPlayer(player: Player) {
        try! realm.write {
            self.realm.add(player)
        }
    }
    
    static func addPlayer(name name: String, rating: Double) {
        let player = Player()
        player.name = name
        player.rating = rating
        
        addPlayer(player)
    }
    
    static func removePlayer(player: Player) {
        try! realm.write {
            self.realm.delete(player)
        }
    }
    
    static func removePlayer(indexPath: NSIndexPath) {
        guard let player = playerForIndexPath(indexPath) else {
            return
        }
        
        removePlayer(player)
    }
    
    static func removeAll() {
        try! realm.write {
            self.realm.deleteAll()
        }
    }
}
