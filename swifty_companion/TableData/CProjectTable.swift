//
//  CProjectTable.swift
//  swifty_companion
//
//  Created by Kristine Sonu on 1/8/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit

class CProjectTable: UITableViewCell {

    @IBOutlet weak var CprojectName: UILabel!
    @IBOutlet weak var CprojectGrade: UILabel!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }


}
