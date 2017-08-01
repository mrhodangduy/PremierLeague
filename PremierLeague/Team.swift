//
//  Team.swift
//  PremierLeague
//
//  Created by QTS Coder on 8/1/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation

var numberofteams:Int?

struct Teams {
    let name: String
    let code: String
    let shortName: String
    var crestUrl = ""
    
    enum sync:Error {
        case missing(String)
        case invalid(String)
    }
    
    
    init(json: [String:AnyObject]) throws {
        guard let name = json["name"] as? String else { throw sync.missing("name is missing")}
        guard let code = json["code"] as? String else { throw sync.missing("code is missing")}
        guard let shortName = json["shortName"] as? String else { throw sync.missing("shortName is missing")}
        guard let crestUrl = json["crestUrl"] as? String else { throw sync.missing("crestUrl is missing")}
        
        self.name = name
        self.code = code
        self.shortName = shortName
        self.crestUrl = crestUrl
        
    }
    
    static let basePath = "https://jsonblob.com/api/jsonBlob/21ed2281-768b-11e7-9e0d-8985f854fbdf"
    
    static func getTeams(completion: @escaping ([Teams]?) -> ())
    {
        let url = URL(string: basePath)
        let task = URLSession.shared.dataTask(with: url!) { (data, respone, error) in
            
            var arrayTeams = [Teams]()
            
            if error != nil
            {
                print(error!)
            }
            else
            {
                if let content = data
                {
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as? [String: AnyObject]
                        
                        numberofteams = (json?["count"] as? Int)!
                        
                        if let jsonTeam = json?["teams"] as? Array<[String:AnyObject]>
                        {
                            for team in jsonTeam
                            {
                                let teamObject = try? Teams(json: team)
                                arrayTeams.append(teamObject!)
                                
                            }
                        }
                    }
                    catch
                    {
                        print("Loi")
                    }
                    
                    completion(arrayTeams)
                }
            }
        }
        task.resume()
    }
    
}















