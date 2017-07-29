//
//  Table.swift
//  PremierLeague
//
//  Created by Paul on 7/29/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation

struct Standing {
    let position:Int
    let teamName: String
    let crestURI: String
    let playedGames:Int
    let points:Int
    let goals: Int
    let goalsAgainst: Int
    let goalDifference: Int
    let wins: Int
    let losses:Int
    let draws: Int
    let home: [String:AnyObject]
    let away: [String:AnyObject]
    
    enum sync:Error {
        case missing(String)
        case invalid(String)
    }
    
    
    init (json: [String: AnyObject]) throws
    {
        
        guard let position = json["position"] as? Int else { throw sync.missing("position is missing")}
        guard let teamName = json["teamName"] as? String else { throw sync.missing("teamName is missing")}
        guard let crestURI = json["crestURI"] as? String else { throw sync.missing("crestURI is missing")}
        guard let playedGames = json["playedGames"] as? Int else { throw sync.missing("playedGames is missing")}
        guard let points = json["points"] as? Int else { throw sync.missing("points is missing")}
        guard let goals = json["goals"] as? Int else { throw sync.missing("goals is missing")}
        guard let goalsAgainst = json["goalsAgainst"] as? Int else { throw sync.missing("goalsAgainst is missing")}
        guard let goalDifference = json["goalDifference"] as? Int else { throw sync.missing("goalDifference is missing")}
        guard let wins = json["wins"] as? Int else { throw sync.missing("wins is missing")}
        guard let losses = json["losses"] as? Int else { throw sync.missing("losses is missing")}
        guard let draws = json["draws"] as? Int else { throw sync.missing("draws is missing")}
        guard let home = json["home"] as? [String:AnyObject] else { throw sync.missing("home is missing")}
        guard let away = json["away"] as? [String:AnyObject] else { throw sync.missing("away is missing")}
        
        self.position = position
        self.teamName = teamName
        self.crestURI = crestURI
        self.playedGames = playedGames
        self.points = points
        self.goals = goals
        self.goalsAgainst = goalsAgainst
        self.goalDifference = goalDifference
        self.wins = wins
        self.losses = losses
        self.draws = draws
        self.home = home
        self.away = away
       
    }
    
    static let basePath = "http://api.football-data.org/v1/competitions/446/leagueTable"
    
    static func tableLeague (completion: @escaping ([Standing]?) -> ())
    {
        let url = URL(string: basePath)
        let task = URLSession.shared.dataTask(with: url!) { (data, respone, error) in
            
            var arrayStanding = [Standing]()
            
            if error != nil
            {
                print("Loi: \(error!)")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as? [String: AnyObject]
                        
                        if let standing = myJson?["standing"] as? Array<[String:AnyObject]>
                        {
                            for standingObject in standing
                            {
                                if let object = try? Standing(json: standingObject)
                                {
                                    arrayStanding.append(object)
                                }
                            }
                        }
                        
                    }
                    catch
                    {
                        print("loi roi")
                    }
                    
                    completion(arrayStanding)
                }
            }
        }
        task.resume()
                
    }
    
}
//struct Home {
//    
//    let goals: Int
//    let goalsAgainst: Int
//    let losses: Int
//    let wins: Int
//    let draws: Int
//    
//}
//struct Away {
//    let goals: Int
//    let goalsAgainst: Int
//    let losses: Int
//    let wins: Int
//    let draws: Int
//}
