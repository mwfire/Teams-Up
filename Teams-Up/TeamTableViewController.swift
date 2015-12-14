//
//  TeamTableViewController.swift
//  Teams-Up
//
//  Created by Jhoan Arango on 11/27/15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController {
    
    let teamsDataSource = TeamsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Table view data source

extension TeamTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return teamsDataSource.numberOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsDataSource.numberOfRowsInSection(section)
    }
    
    // Section Title
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let team = teamsDataSource.teamForSection(section) else {
            return ""
        }
        return team.name
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("team cell", forIndexPath: indexPath) as! TeamTableViewCell
        
        guard let player = teamsDataSource.playerAtIndexPath(indexPath) else {
            return cell
        }
        
        cell.teamPlayerLabel.text = player.name
        return cell
    }
    
    // Code by thedan84
    /// Logo VS for section 1
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section >= 1 {
            return nil
        }
        
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        
        let image = UIImage(named: "VS Oval")
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(footerView.center.x - 35, footerView.center.y, 70, 70)
        
        footerView.addSubview(imageView)
        
        return footerView
        
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80.0
    }
}

