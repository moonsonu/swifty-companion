//
//  FTprojectSection.swift
//  swifty_companion
//
//  Created by Kristine Sonu on 1/9/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import Foundation
import SwiftyJSON

class FTprojectSection: SectionProtocol {
    var ftproject: [String]?
    var ftgrade: [String]?
    var ftvalid: [String]?
    var grade: String?
    var SecType: SectionType{
        return .FTprojects
    }
    
    var SecName: String {
        return "     FT projects"
    }
    
    var RowNum: Int {
        if let num = ftproject {
            return num.count
        }
        else {
            return 0
        }
    }
    init(for data: JSON) {
        for ft in data["projects_users"] {
            if ft.1["cursus_ids"][0].int != 4 {
                if ft.1["project"]["parent_id"].string == nil {
                    let tf = ("\(ft.1["validated?"])")
                    if (ftvalid?.append(tf)) == nil {
                        ftvalid = [tf]
                    }
                    if (ft.1["status"] != "finished") {
                        grade = ("\(ft.1["status"])")
                    }
                    else if (ft.1["marked"] == false) {
                        grade = "Not Finished"
                    }
                    else {
                        grade = ("\(ft.1["final_mark"])")
                    }
                    if (ftgrade?.append(grade!)) == nil {
                        ftgrade = [grade] as? [String]
                    }
                    let result = ("\(ft.1["project"]["name"])")
                    if (ftproject?.append(result)) == nil {
                        ftproject = [result]
                    }
                }
            }
        }
    }
}
