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
    var visibleCells = Set<NSIndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: Table view data source

extension TeamTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return teamsDataSource.numberOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsDataSource.numberOfRowsInSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("teamCell", forIndexPath: indexPath) as! TeamTableViewCell
        
        guard let player = teamsDataSource.playerAtIndexPath(indexPath) else {
            return cell
        }
        
        cell.teamPlayerLabel.text = player.name
        return cell
    }

    // Will animate cells
    // Found in https://www.youtube.com/watch?v=08eurHsO83w
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if !visibleCells.contains(indexPath) {
            let moveCellAnimation = CATransform3DTranslate(CATransform3DIdentity, 400, 0, 0)
            cell.layer.transform = moveCellAnimation
            
            UIView.animateWithDuration(0.5) { () -> Void in
                cell.layer.transform = CATransform3DIdentity
            }
            
            visibleCells.insert(indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
      
        let moveCellAnimation = CATransform3DTranslate(CATransform3DIdentity, -400, 0, 0)
        
        view.layer.transform = moveCellAnimation
        
        UIView.animateWithDuration(1) { () -> Void in
            view.layer.transform = CATransform3DIdentity
        }
    }
}


// MARK: Table view delegates

extension TeamTableViewController {
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCellWithIdentifier("teamSection") as! TeamSectionTableViewCell
        if let team = teamsDataSource.teamForSection(section) {
            headerView.titleLabel.text = team.name
            headerView.starRating.rating = team.averageRating
        }
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
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

