//
//  Player.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 11/28/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import Foundation
import RealmSwift

class Player: Object {
    dynamic var name: String = ""
    dynamic var rating: Double = 5.0
    
    convenience required init(name: String, rating: Double = 5.0) {
        self.init()
        self.name = name
        self.rating = rating
    }
}