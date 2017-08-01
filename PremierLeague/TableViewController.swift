//
//  TableViewController.swift
//  PremierLeague
//
//  Created by Paul on 7/29/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    var arrayStandingTotal = [Standing]()
    
    @IBOutlet weak var total: UIButton!
    @IBOutlet weak var home: UIButton!
    @IBOutlet weak var away: UIButton!
    @IBOutlet weak var totalTableView: UITableView!
    @IBOutlet weak var tableScrollView: UIScrollView!
    
    @IBOutlet weak var lblNumberofMath: UILabel!
    @IBOutlet weak var lblGDGoal: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    
    var buttonIsSelected = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalTableView.delegate = self
        totalTableView.dataSource = self
        
        let queue = DispatchQueue(label: "get data", qos: .default, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activity.frame = CGRect(x: self.view.frame.width/2-10, y: self.view.frame.height/2-30, width: 20, height: 20)
        
        activity.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        activity.hidesWhenStopped = true
        activity.startAnimating()
        
        self.view.addSubview(activity)
        
        queue.async {
            Standing.tableLeague(leagueID: 444) { (results) in
                for result in results!
                {
                    self.arrayStandingTotal.append(result)
                    DispatchQueue.main.async {
                        self.totalTableView.reloadData()
                        activity.stopAnimating()
                    }
                }
            }
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func totalAction(_ sender: UIButton) {
        
        sender.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        home.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        away.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        buttonIsSelected = 1
        totalTableView.reloadData()
        
        
    }
    
    @IBAction func homeAction(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        total.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        away.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        buttonIsSelected = 2
        totalTableView.reloadData()
        
        
    }
    
    @IBAction func awayAction(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        total.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        home.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        buttonIsSelected = 3
        totalTableView.reloadData()
        
        
    }
    
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayStandingTotal.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Table_TableViewCell
        
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        }
        else
        {
            cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        
        let standingObject = arrayStandingTotal[indexPath.row]
        

        switch buttonIsSelected {
        case 1:
            
            cell.lblRank.text = String(standingObject.position)
            cell.lblClubName.text = standingObject.teamName
            lblNumberofMath.text = "P"
            lblGDGoal.text = "GD"
            lblPoints.text = "PTS"
            cell.lblNumberofMatch.text = String(standingObject.playedGames)
            cell.lblGDGoal.text = String(standingObject.goalDifference)
            cell.lblPoints.text = String(standingObject.points)
            
        case 2:
            
            cell.lblRank.text = ""
            cell.lblClubName.text = standingObject.teamName
            lblNumberofMath.text = "W"
            lblGDGoal.text = "D"
            lblPoints.text = "L"
            cell.lblNumberofMatch.text = String(describing: (standingObject.home["wins"]) as! Int)
            
            cell.lblGDGoal.text = String(standingObject.home["draws"] as! Int)
            cell.lblPoints.text = String(describing: (standingObject.home["losses"]) as! Int)
            
        case 3:
            
            cell.lblClubName.text = standingObject.teamName
            lblNumberofMath.text = "W"
            lblGDGoal.text = "D"
            lblPoints.text = "L"
            cell.lblNumberofMatch.text = String(describing: (standingObject.away["wins"]) as! Int)
            cell.lblGDGoal.text = String(describing: (standingObject.away["draws"]) as! Int)
            cell.lblPoints.text = String(describing: (standingObject.away["losses"]) as! Int)
        default:
            print("default")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}





