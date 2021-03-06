//
//  MatchesTableViewController.swift
//  PremierLeague
//
//  Created by QTS Coder on 7/28/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class MatchesTableViewController: UITableViewController {
    
    var arrMatchesList = [Match]()
    
    var refresher:UIRefreshControl!
    
    @IBOutlet weak var menuBar: UIBarButtonItem!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector (MatchesTableViewController.refresh), for: UIControlEvents.touchDown)
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        self.view.addSubview(refresher)
        
        let queue = DispatchQueue(label: "get data", qos: .default, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activity.frame = CGRect(x: self.view.frame.width/2-10, y: self.view.frame.height/2-30, width: 20, height: 20)

        activity.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        activity.hidesWhenStopped = true
        activity.startAnimating()
        
        self.view.addSubview(activity)
        
        queue.async {
            Match.matchList(leagueID: 444, completion: { (results) in
                for result in results!
                {
                    self.arrMatchesList.append(result)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        activity.stopAnimating()
                    }
                }
            })
            
        }
        
    }
    
    func refresh() {
        
        tableView.reloadData()
        refresher.endRefreshing()
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
        return arrMatchesList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MatchesTableViewCell
        
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        }
        else
        {
            cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        
        let match = arrMatchesList[indexPath.row]
        
        ///convert string to date
        
        let date = match.date
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formater.locale = Locale.current
        let dateString  = formater.date(from: date)
        
        //        print(dateString!)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM,hh:mm a"
        let result = formatter.string(from:dateString!)
       
       
        //        print(result.components(separatedBy: ", "))
        
        // get Status data
        
        
        
        //config cell
        
        cell.lblHometeam.text = match.homeTeamName
        cell.lblAwayteam.text = match.awayTeamName
        
        if (match.result["goalsHomeTeam"] as? Int) == nil || (match.result["goalsAwayTeam"] as? Int) == nil
        {
            cell.lblHomeScore.text = ""
            cell.lblAwayScore.text = ""
            
        }
        else
        {
            cell.lblHomeScore.text = String(describing: (match.result["goalsHomeTeam"] as? Int)!)
            cell.lblAwayScore.text = String(describing: (match.result["goalsAwayTeam"] as? Int)!)
        }
        
        let status = match.status
        if status == "FINISHED"
        {
            cell.lblFullTime.text = "FT"
            cell.lblDate.text = ""
            cell.lblTime.text = ""

        } else
        {
            cell.lblFullTime.text = ""
            cell.lblDate.text = result.components(separatedBy: ",")[0]
            cell.lblTime.text = result.components(separatedBy: ",")[1]

        }
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
