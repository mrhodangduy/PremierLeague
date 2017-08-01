//
//  MenuTableViewController.swift
//  PremierLeague
//
//  Created by QTS Coder on 7/31/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var arrLeague = [Competitions]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Competitions.competition { (results) in
            for result in results!
            {
                self.arrLeague.append(result)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrLeague.count  
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let leagueObject = arrLeague[indexPath.row]
        
        cell.textLabel?.text = leagueObject.caption
        
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arrLeague[indexPath.row].id)
        
        leagueId = arrLeague[indexPath.row].id
//        performSegue(withIdentifier: "leagueSegue", sender: self)
        
    }

}
