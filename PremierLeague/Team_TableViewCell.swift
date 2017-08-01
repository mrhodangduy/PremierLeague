//
//  Team_TableViewCell.swift
//  PremierLeague
//
//  Created by QTS Coder on 8/1/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class Team_TableViewCell: UITableViewCell {

    @IBOutlet weak var imageTeam: UIImageView!
    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var lblstt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
