//
//  SkillTable.swift
//  swifty_companion
//
//  Created by Kristine Sonu on 1/8/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit

class SkillTable: UITableViewCell {

    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var skillLevel: UILabel!
    @IBOutlet var SPB: SkillProgressBar!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
