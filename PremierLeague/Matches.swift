//
//  Matches.swift
//  PremierLeague
//
//  Created by QTS Coder on 7/28/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation



struct Match {
    let date:String
    let status:String
    let matchday:Int
    let homeTeamName:String
    let awayTeamName:String
    let result:[String:AnyObject]
    
    enum sync:Error {
        case missing(String)
        case invalid(String)
    }
    
    init (json: [String:AnyObject]) throws
    {
        guard let date = json["date"] as? String else { throw sync.missing("date is missing")}
        guard let status = json["status"] as? String else { throw sync.missing("status is missing")}
        guard let matchday = json["matchday"] as? Int else { throw sync.missing("matchday is missing")}
        guard let homeTeamName = json["homeTeamName"] as? String else { throw sync.missing("homeTeamName is missing")}
        guard let awayTeamName = json["awayTeamName"] as? String else { throw sync.missing("awayTeamName is missing")}
        guard let result = json["result"] as? [String:AnyObject] else { throw sync.missing("result is missing")}
        
        self.date = date
        self.status = status
        self.matchday = matchday
        self.homeTeamName = homeTeamName
        self.awayTeamName = awayTeamName
        self.result = result
    }
    
    static let basePath:String = "http://api.football-data.org/v1/competitions/445/fixtures"
    
    static func matchList (completion: @escaping ([Match]?) -> ())
    {
        let url = URL(string: basePath)
        let task = URLSession.shared.dataTask(with: url!) { (data, respone, error) in
            
            var arrayMatchList = [Match]()
            
            if error != nil
            {
                print(error!)
            } else
            {
                if let content = data
                {
                    do
                    {
                        let myjson = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as? [String: AnyObject]
                        
                       
                        if let fixtures = myjson?["fixtures"] as? [[String:AnyObject]]
                        {
                            for fixture in fixtures
                            {
                                let matchObject = try? Match(json: fixture)
                                
                                arrayMatchList.append(matchObject!)
                                

                            }
                            
                        }
                        
                        
                    } catch
                    {
                        print("loi")
                    }
                    
                    completion(arrayMatchList)
                }
            }
        }
        task.resume()
    }
    
    
    
    
}
















