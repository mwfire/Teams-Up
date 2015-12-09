//
//  PlayersDataSourceTests.swift
//  Teams-Up
//
//  Created by Martin Wildfeuer on 08.12.15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import XCTest
import RealmSwift


class PlayersDataSourceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        // Remove all players before running individual tests
        PlayersDataSource.removeAll()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testThatPlayerIsAddedCorrectly() {
        
        // Player list should be empty when running this test
        XCTAssertEqual(PlayersDataSource.numberOfRows, 0, "Players data source should be empty")
        
        PlayersDataSource.addPlayer(name: "Testname", rating: 4.0)
        
        XCTAssertEqual(PlayersDataSource.numberOfRows, 1, "Players data source should contain one entry")
        XCTAssertEqual(PlayersDataSource.players.count, 1, "Players data source should contain one entry")
        
        if let player = PlayersDataSource.players.first {
            XCTAssertEqual(player.name, "Testname", "Player name does not match expected player")
            XCTAssertEqual(player.rating, 4.0, "Player rating does not match expected player")
        } else {
            XCTFail("Player was not added to data source correctly")
        }
    }
    
    func testThatPlayerForIndexPathWorksCorrectly() {
        
        // Player list should be empty when running this test
        XCTAssertEqual(PlayersDataSource.numberOfRows, 0, "Players data source should be empty")
        
        PlayersDataSource.addPlayer(name: "TestnameOne", rating: 1.0)
        PlayersDataSource.addPlayer(name: "TestnameTwo", rating: 2.0)
        PlayersDataSource.addPlayer(name: "TestnameThree", rating: 3.0)
        
        let indexPath = NSIndexPath(forRow: 1, inSection: 1)
        
        if let player = PlayersDataSource.playerForIndexPath(indexPath) {
            XCTAssertEqual(player.name, "TestnameTwo", "Player name does not match expected player")
            XCTAssertEqual(player.rating, 2.0, "Player rating does not match expected player")
        } else {
            XCTFail("Player was not added to data source correctly")
        }
    }
    
    func testThatPlayerForInvalidIndexPathWorksCorrectly() {
        
        // Player list should be empty when running this test
        XCTAssertEqual(PlayersDataSource.numberOfRows, 0, "Players data source should be empty")
        
        PlayersDataSource.addPlayer(name: "Testname", rating: 1.0)
        
        let indexPath = NSIndexPath(forRow: 2, inSection: 1)
        
        if let _ = PlayersDataSource.playerForIndexPath(indexPath) {
            XCTFail("No player should be returned for invalid index paths")
        }
    }
    
    func testThatPlayerIsRemovedCorrectly() {
        
        // Player list should be empty when running this test
        XCTAssertEqual(PlayersDataSource.numberOfRows, 0, "Players data source should be empty")
        
        PlayersDataSource.addPlayer(name: "TestnameOne", rating: 1.0)
        PlayersDataSource.addPlayer(name: "TestnameTwo", rating: 2.0)
        PlayersDataSource.addPlayer(name: "TestnameThree", rating: 3.0)
        
        let indexPath = NSIndexPath(forRow: 1, inSection: 1)
        
        XCTAssertEqual(PlayersDataSource.numberOfRows, 3, "Players data source entries count does not match expected result")
        
        PlayersDataSource.removePlayer(indexPath)
        XCTAssertEqual(PlayersDataSource.numberOfRows, 2, "Players data source entries count does not match expected result")
        
        if let player = PlayersDataSource.playerForIndexPath(indexPath) {
            XCTAssertEqual(player.name, "TestnameThree", "Player name does not match expected player")
            XCTAssertEqual(player.rating, 3.0, "Player rating does not match expected player")
        } else {
            XCTFail("Player was not removed from data source correctly")
        }
    }

}


