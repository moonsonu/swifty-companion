//
//  CpiscineSection.swift
//  swifty_companion
//
//  Created by Kristine Sonu on 1/9/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import Foundation
import SwiftyJSON

class CpiscineSection: SectionProtocol {
    var cpiscine: [String]?
    var cpgrade: [String]?
    var cpvalid: [String]?
    var grade: String?
    var SecType: SectionType{
        return .Cpiscine
    }
    
    var SecName: String {
        return "     C piscine"
    }
    
    var RowNum: Int {
        if let num = cpiscine {
            return num.count
        }
        else {
            return 0
        }
    }
    init(for data: JSON) {
        for cp in data["projects_users"] {
            if (cp.1["cursus_ids"][0].int == 4) && (cp.1["project"]["parent_id"].int != 167){
                let tf = ("\(cp.1["validated?"])")
                if (cpvalid?.append(tf)) == nil {
                    cpvalid = [tf]
                }
                if (cp.1["status"] != "finished") {
                    grade = ("\(cp.1["status"])")
                }
                else if (cp.1["marked"] == false) {
                    grade = "Not Finished"
                }
                else {
                    grade = ("\(cp.1["final_mark"])")
                }
                if (cpgrade?.append(grade!)) == nil {
                    cpgrade = [grade] as? [String]
                }
                let result = ("\(cp.1["project"]["name"])")
                if (cpiscine?.append(result)) == nil {
                    cpiscine = [result]
                }
            }
        }
    }
}
