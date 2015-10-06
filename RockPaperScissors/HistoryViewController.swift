//
//  HistoryViewController.swift
//  RockPaperScissors
//
//  Created by Khoa Vo on 10/5/15.
//  Copyright © 2015 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var historyTable: UITableView!
    
    var history = [RPSMatch]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell") as UITableViewCell!
        
        let match = history[indexPath.row]
        let title = cellTitle(match)
        
        cell.textLabel?.text = title
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.imageView?.image = UIImage(named: "\(match.p1)")
        
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = "\(match.p1) vs. \(match.p2)"
            detailTextLabel.textColor = UIColor.whiteColor()
        }
        
        switch title {
        case "Win!":
            cell.backgroundColor = UIColor(red: 75/255.0, green: 129/255.0, blue: 153/255.0, alpha: 0.9)
        case "Lose!":
            cell.backgroundColor = UIColor(red: 158/255.0, green: 18/255.0, blue: 48/255.0, alpha: 0.9)
        default:
            cell.backgroundColor = UIColor.grayColor()
        }
        
        return cell
    }
    
    func cellTitle(match: RPSMatch) -> String {
        if match.p1 == match.p2 {
            return "Tie!"
        } else {
            return match.p1.defeats(match.p2) ? "Win!" : "Lose!"
        }
    }
    
    @IBAction func clearHistory(sender: UIBarButtonItem) {
        history = []
        historyTable.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        /* Pass history back to RockPaperScissorsViewController to maintain match history, otherwise history will 
        reset when segue occurs. */
        let controller = segue.destinationViewController as! RockPaperScissorsViewController
        controller.history = self.history
    }
    
}