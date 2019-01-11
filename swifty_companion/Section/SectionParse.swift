//
//  SectionParse.swift
//  swifty_companion
//
//  Created by Kristine Sonu on 1/9/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import Foundation

enum SectionType {
    case Cpiscine
    case FTprojects
//    case PHPpiscine
//    case CPPpiscine
//    case IVpiscine
    
}

protocol SectionProtocol {
    var SecType: SectionType { get }
    var SecName: String { get }
    var RowNum: Int { get }
}
