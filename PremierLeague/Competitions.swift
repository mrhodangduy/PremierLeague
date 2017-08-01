//
//  Competitions.swift
//  PremierLeague
//
//  Created by QTS Coder on 7/31/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation

struct Competitions {
    let id: Int
    let caption: String
    let league: String
    let year: String
    let currentMatchday: Int
    let numberOfMatchdays: Int
    let numberOfTeams: Int
    let numberOfGames: Int
    let lastUpdated: String
    
    enum sync:Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json: [String:AnyObject]) throws {
        guard let id = json["id"] as? Int else { throw sync.missing("id is missing") }
        guard let caption = json["caption"] as? String else { throw sync.missing("caption is missing") }
        guard let league = json["league"] as? String else { throw sync.missing("league is missing") }
        guard let year = json["year"] as? String else { throw sync.missing("year is missing") }
        guard let currentMatchday = json["currentMatchday"] as? Int else { throw sync.missing("currentMatchday is missing") }
        guard let numberOfMatchdays = json["numberOfMatchdays"] as? Int else { throw sync.missing("numberOfMatchdays is missing") }
        guard let numberOfTeams = json["numberOfTeams"] as? Int else { throw sync.missing("numberOfTeams is missing") }
        guard let numberOfGames = json["numberOfGames"] as? Int else { throw sync.missing("numberOfGames is missing") }
        guard let lastUpdated = json["lastUpdated"] as? String else { throw sync.missing("lastUpdated is missing") }
        
        
        self.id = id
        self.caption = caption
        self.league = league
        self.year = year
        self.currentMatchday = currentMatchday
        self.numberOfMatchdays = numberOfMatchdays
        self.numberOfTeams = numberOfTeams
        self.numberOfGames = numberOfGames
        self.lastUpdated = lastUpdated

    }
    
    static let basePath = "https://api.myjson.com/bins/bhfj9"
    
    static func competition (completion: @escaping ([Competitions]?)->())
    {
        let url = URL(string: basePath)
        let task = URLSession.shared.dataTask(with: url!) { (data, respone, error) in
            
            var arrCompetitions = [Competitions]()
            
            if error != nil
            {
                print(error!)
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let jsonData = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as! Array<[String:AnyObject]>
                        
                        for data in jsonData {
                            let leagueObject = try? Competitions(json: data)
                            arrCompetitions.append(leagueObject!)
                        }
                    } catch
                    {
                        print("Loi")
                    }
                    completion(arrCompetitions)
                }
            }
        }
        task.resume()
    }
    
}














