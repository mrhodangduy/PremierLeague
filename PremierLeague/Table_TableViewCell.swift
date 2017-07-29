//
//  Table_TableViewCell.swift
//  PremierLeague
//
//  Created by Paul on 7/29/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class Table_TableViewCell: UITableViewCell {

    @IBOutlet weak var lblRank: UILabel!
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblNumberofMatch: UILabel!
    @IBOutlet weak var lblGDGoal: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
