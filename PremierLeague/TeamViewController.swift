//
//  TeamViewController.swift
//  PremierLeague
//
//  Created by QTS Coder on 8/1/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController {
    
    @IBOutlet weak var lblnumberofTeam: UILabel!
    @IBOutlet weak var teamTableView: UITableView!
    
    var arrayTeam = [Teams]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamTableView.delegate = self
        teamTableView.dataSource = self
        
        let queue = DispatchQueue(label: "get data", qos: .default, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activity.frame = CGRect(x: self.view.frame.width/2-10, y: self.view.frame.height/2-30, width: 20, height: 20)
        
        activity.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        activity.hidesWhenStopped = true
        activity.startAnimating()
        
        self.view.addSubview(activity)
        
        queue.async {
            Teams.getTeams { (results) in
                
                for result in results!
                {
                    self.arrayTeam.append(result)
                    DispatchQueue.main.async {
                        self.teamTableView.reloadData()
                        activity.stopAnimating()
                    }
                }
                self.lblnumberofTeam.text = String(self.arrayTeam.count)
                
            }
        }
        
    }
    
}

extension TeamViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTeam.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Team_TableViewCell
        
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        }
        else
        {
            cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }

        
        let teamObject = arrayTeam[indexPath.row]
        
        cell.lblstt.text = String(indexPath.row + 1)
//        cell.imageTeam.loadImage(link: teamObject.crestUrl)
        cell.lblTeamName.text = teamObject.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arrayTeam[indexPath.row].crestUrl)
    }
    
}







