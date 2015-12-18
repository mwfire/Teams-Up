//
//  TeamsDataSource.swift
//  Teams-Up
//
//  Created by Martin Wildfeuer on 13.12.15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import Foundation


struct TeamsDataSource {
    
    private let teamA = Team(name: "Team 1")
    private let teamB = Team(name: "Team 2")
    private let playersDataSource: PlayersDataSource
    
    private mutating func balanceTeams() {
        
        // Clear teams
        teamA.players.removeAll()
        teamB.players.removeAll()
        
        // Jhoan Arango
        // Sort players descending
        let players = playersDataSource.players
        let sortedPlayers = players.sort { (player: Player, player2: Player) -> Bool in
            return player.rating > player2.rating
        }
        
        // Jhoan Arango
        // Assigning players to teams by Jhoan Arango
        for player in sortedPlayers {
            switch player {
            case _ where teamA.players.count <= teamB.players.count:
                if teamA.totalRating > teamB.totalRating {
                    teamB.players += [player]
                } else {
                    teamA.players += [player]
                }
            case _ where teamA.players.count >= teamB.players.count:
                if teamA.totalRating < teamB.totalRating {
                    teamA.players += [player]
                } else {
                    teamB.players += [player]
                }
            default: break
            }
        }
    }
    
    init() {
        playersDataSource = PlayersDataSource()
        balanceTeams()
    }
    
    init(playersDataSource: PlayersDataSource) {
        self.playersDataSource = playersDataSource
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
