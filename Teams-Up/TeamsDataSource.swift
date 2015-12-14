//
//  TeamsDataSource.swift
//  Teams-Up
//
//  Created by Martin Wildfeuer on 13.12.15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import Foundation


struct TeamsDataSource {
    
    let teamA = Team(name: "Team 1")
    let teamB = Team(name: "Team 2")
    
    let playersDataSource = PlayersDataSource()
    
    mutating func balanceTeams() {
        
        // Clear teams
        teamA.players.removeAll()
        teamB.players.removeAll()
        
        // Sort players descending
        let players = playersDataSource.players
        let sortedPlayers = players.sort { (player: Player, player2: Player) -> Bool in
            return player.rating > player2.rating
        }
        
        // Assigning players to teams via "The Greedy Algorithm"
        // https://en.wikipedia.org/wiki/Partition_problem
        for player in sortedPlayers {
            if teamA.totalRating <  teamB.totalRating {
                teamA.players += [player]
            } else {
                teamB.players += [player]
            }
        }
    }
    
    init() {
        balanceTeams()
    }
    
    mutating func reload() {
        balanceTeams()
    }
}

// MARK: Data source for table views

extension TeamsDataSource {
   
    var numberOfSections: Int {
        return 2
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return teamA.players.count
        case 1:
            return teamB.players.count
        default:
            return 0
        }
    }
    
    func playerAtIndexPath(indexPath: NSIndexPath) -> Player? {
        switch indexPath.section {
        case 0:
            guard teamA.players.indices ~= indexPath.row else {
                return nil
            }
            return teamA.players[indexPath.row]
        case 1:
            guard teamB.players.indices ~= indexPath.row else {
                return nil
            }
            return teamB.players[indexPath.row]
        default:
            return nil
        }
    }
    
    func teamForSection(section: Int) -> Team? {
        switch section {
        case 0:
            return teamA
        case 1:
            return teamB
        default:
            return nil
        }
    }
}
