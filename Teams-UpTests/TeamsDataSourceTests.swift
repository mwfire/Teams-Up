//
//  TeamsDataSourceTests.swift
//  Teams-Up
//
//  Created by Martin Wildfeuer on 14.12.15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import XCTest

class TeamsDataSourceTests: XCTestCase {
    
    let playersDataSource = PlayersDataSource(userDefaults: FakeUserDefaults(suiteName: "TeamsUpTest")! )
    var teamsDataSource: TeamsDataSource?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        playersDataSource.removeAll()
        playersDataSource.addPlayer(name: "PlayerOne", rating: 5.0)
        playersDataSource.addPlayer(name: "PlayerTwo", rating: 1.0)
        playersDataSource.addPlayer(name: "PlayerThree", rating: 4.0)
        playersDataSource.addPlayer(name: "PlayerFour", rating: 2.0)
        teamsDataSource = TeamsDataSource(playersDataSource: playersDataSource)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatTeamsAreBuiltCorrectly() {

        if let teamA = teamsDataSource!.teamForSection(0) {
            XCTAssertEqual(teamA.name, "Team 1", "Team name does not match expected name")
            XCTAssertEqual(teamsDataSource!.numberOfRowsInSection(0), 2, "Number of rows does not match expected number")
        } else {
            XCTFail("Team one was not returned correctly")
        }
        
        if let teamB = teamsDataSource!.teamForSection(1) {
            XCTAssertEqual(teamB.name, "Team 2", "Team name does not match expected name")
            XCTAssertEqual(teamsDataSource!.numberOfRowsInSection(1), 2, "Number of rows does not match expected number")
        } else {
            XCTFail("Team two was not returned correctly")
        }
    }
    
    func testThatTeamsAreBalancedCorrectly() {
        
        if let teamA = teamsDataSource!.teamForSection(0) {
            XCTAssertEqual(teamA.totalRating, 6.0, "Total rating does not match expected value")
            XCTAssertEqual(teamA.averageRating, 3.0, "Average rating does not match expected value")
            
            var indexPath = NSIndexPath(forRow: 0, inSection: 0)
            var player = teamsDataSource!.playerAtIndexPath(indexPath)
            XCTAssertEqual(player!.name, "PlayerThree", "Player name does not match expected name")
            indexPath = NSIndexPath(forRow: 1, inSection: 0)
            player = teamsDataSource!.playerAtIndexPath(indexPath)
            XCTAssertEqual(player!.name, "PlayerFour", "Player name does not match expected name")
        } else {
            XCTFail("Team one was not returned correctly")
        }
        
        if let teamB = teamsDataSource!.teamForSection(1) {
            XCTAssertEqual(teamB.totalRating, 6.0, "Total rating does not match expected value")
            XCTAssertEqual(teamB.averageRating, 3.0, "Average rating does not match expected value")
            
            var indexPath = NSIndexPath(forRow: 0, inSection: 1)
            var player = teamsDataSource!.playerAtIndexPath(indexPath)
            XCTAssertEqual(player!.name, "PlayerOne", "Player name does not match expected name")
            indexPath = NSIndexPath(forRow: 1, inSection: 1)
            player = teamsDataSource!.playerAtIndexPath(indexPath)
            XCTAssertEqual(player!.name, "PlayerTwo", "Player name does not match expected name")
        } else {
            XCTFail("Team two was not returned correctly")
        }
        
    }

}
