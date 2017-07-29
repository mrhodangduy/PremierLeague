//
//  MatchesTableViewCell.swift
//  PremierLeague
//
//  Created by QTS Coder on 7/28/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblHometeam: UILabel!
    @IBOutlet weak var lblAwayteam: UILabel!
    @IBOutlet weak var lblHomeScore: UILabel!
    @IBOutlet weak var lblAwayScore: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
      
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
