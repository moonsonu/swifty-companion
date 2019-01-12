//
//  Profile.swift
//  swifty_companion
//
//  Created by Kristine Sonu on 1/3/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class PageThree: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var json: JSON?
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var intra: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var progressbar: UIProgressView!
    
    var sections : [SectionProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicture()
        progressBar()
        
        let LogIn = json!["login"].string
        intra.text = LogIn
        
        table.delegate = self
        table.dataSource = self

        table.estimatedRowHeight = 44
        table.rowHeight = UITableView.automaticDimension
        
        table?.register(CProjectTable.nib, forCellReuseIdentifier: CProjectTable.identifier)
        table?.register(FTProjectTable.nib, forCellReuseIdentifier: FTProjectTable.identifier)

    }
    
    func progressBar() {
        let normalize: ((Float) -> Float) = { (input) in
            return roundf(input * 100) / 100
        }
        progressbar.transform = progressbar.transform.scaledBy(x: 1, y: 5)
        progressbar.layer.cornerRadius = 10
        progressbar.clipsToBounds = true
        let maxlevel = json!["cursus_users"][0]["level"].float
        progressbar.progress = maxlevel! / 21
        level.text = "level : " + "\(normalize(maxlevel!))"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sections[section].RowNum != 0 {
        let label = UILabel()
        label.text = sections[section].SecName
        label.textColor = UIColor.white
        label.font = UIFont(name: "futura-Bold", size: 20)
        if sections[section].SecType == .Cpiscine {
            label.backgroundColor = UIColor(red:0.00, green:0.73, blue:0.66, alpha:1.0)
        } else if sections[section].SecType == .FTprojects {
            label.backgroundColor = UIColor(red:0.00, green:0.73, blue:0.66, alpha:1.0)
        }
        return label
        }
        else {
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func profilePicture() {
        perform(#selector(setCircle), with: UIImage.self, afterDelay: 0)
    }
    
    @objc func setCircle() {
        let strUrl = json!["image_url"].string!
        if let url = URL(string: strUrl) {
            if let data = NSData(contentsOf: url) {
                profilePic.image = UIImage(data: data as Data)
                profilePic.layer.cornerRadius = (profilePic.frame.width) / 2
                profilePic.layer.borderWidth = 3
                profilePic.layer.borderColor = UIColor.white.cgColor
                profilePic.clipsToBounds = true
                //profilePic.layer.masksToBounds = true
            } else {
                print("error")}
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].RowNum
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section = sections[indexPath.section]
        switch section.SecType {
        case .Cpiscine:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CprojectCell", for: indexPath) as? CProjectTable {
            let item = sections[indexPath.section] as! CpiscineSection
            cell.CprojectName.text = item.cpiscine?[indexPath.row]
            if (item.cpvalid?[indexPath.row] == "true") {
                cell.CprojectGrade.textColor = UIColor(red:0.00, green:0.68, blue:0.16, alpha:1.0)
            }
            else if (item.cpvalid?[indexPath.row] == "false") {
                cell.CprojectGrade.textColor = UIColor.red
            }
            else {
                cell.CprojectGrade.textColor = UIColor.black
            }
            cell.CprojectGrade.text = item.cpgrade?[indexPath.row]
            return cell
            }
        case .FTprojects:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FTprojectCell", for: indexPath) as? FTProjectTable {
                let item = sections[indexPath.section] as! FTprojectSection
                cell.FTprojectName.text = item.ftproject?[indexPath.row]
                if (item.ftvalid?[indexPath.row] == "true") {
                    cell.FTprojectGrade.textColor = UIColor(red:0.00, green:0.68, blue:0.16, alpha:1.0)
                }
                else if (item.ftvalid?[indexPath.row] == "false") {
                    cell.FTprojectGrade.textColor = UIColor.red
                }
                else {
                    cell.FTprojectGrade.textColor = UIColor.black
                }
                cell.FTprojectGrade.text = item.ftgrade?[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
