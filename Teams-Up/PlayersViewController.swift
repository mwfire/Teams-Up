//
//  PlayersViewController.swift
//  Teams-Up
//
//  Created by Martin Wildfeuer on 12.12.15.
//  Copyright © 2015 Jhoan Arango. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    
    let playersDataSource = PlayersDataSource()
    let popUpViewController = PopUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Let this class be the tableViews delegate and dataSource
        // Dragging a tableViewController to the storyboard, this is
        // automatically hooked up for you. This can also be done in
        // storyboard via connections, but I prefer this way.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add the "add player" popUpView
        addChildViewController(popUpViewController)
        view.addSubview(popUpViewController.view)
        
        updateHeader()
    }
    
    func updateHeader() {
        // Changes the TableViews background when empty
        if playersDataSource.numberOfRows == 0 {
            headerLabel.alpha = 0
            tableView.backgroundView = UIImageView(image: UIImage(named: "Background Empty"))
        } else {
            headerLabel.alpha = 1.0
            tableView.backgroundView = nil
            tableView.backgroundColor = UIColor.blackColor()
            headerLabel.text = "Players: \(playersDataSource.numberOfRows)"
        }
    }
}


// MARK: TableView DataSource

extension PlayersViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return playersDataSource.numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersDataSource.numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("player cell", forIndexPath: indexPath) as! PlayerTableViewCell
        
        guard let player = playersDataSource.playerAtIndexPath(indexPath) else {
            return cell
        }
        
        cell.playerNameLabel.text = player.name
        cell.starRating.rating = player.rating
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            if let _ = playersDataSource.removePlayerAtIndexPath(indexPath) {
                updateHeader()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } else {
                // TODO: Player could not be removed, display an error message
            }
            
        }
    }
    
}


// MARK: TableView Delegate

extension PlayersViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let player = playersDataSource.playerAtIndexPath(indexPath) else {
            return
        }
        
        popUpViewController.updatePlayer(player) { (player, cancelled) -> Void in
            if !cancelled {
                if let player = player {
                    if let _ = self.playersDataSource.updatePlayerAtIndexPath(indexPath, player: player) {
                        self.tableView.reloadData()
                    } else {
                        // TODO: Player could not be updated, display error message
                    }
                }
            }
            self.popUpViewController.dismiss()
        }
    }
}


// MARK: Actions

extension PlayersViewController {
    
    @IBAction func addPlayerTouched(sender: UIBarButtonItem) {
        popUpViewController.addPlayer { (player, cancelled) -> Void in
            if !cancelled {
                if let player = player {
                    self.playersDataSource.addPlayer(player)
                    self.updateHeader()
                    self.tableView.reloadData()
                }
            } else {
                self.popUpViewController.dismiss()
            }
        }
    }
}
