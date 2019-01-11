//
//  PageTwo.swift
//  swifty_companion
//
//  Created by Kristine Sonu on 1/4/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit
import SwiftyJSON

class PageTwo: UIViewController, UITableViewDataSource, UITableViewDelegate {


    var json: JSON?
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var intra: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var progressbar: UIProgressView!
    
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
        return json!["cursus_users"][0]["skills"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell", for: indexPath) as! SkillTable
        let name = json!["cursus_users"][0]["skills"][indexPath.row]["name"].string
        let level = json!["cursus_users"][0]["skills"][indexPath.row]["level"].float
        let level2 = level! / 20
        cell.contentView.backgroundColor = UIColor.clear
        cell.skillName.text = name!
        cell.skillLevel.text = String(level!)
        cell.skillName.numberOfLines = 0
        
        cell.SPB.trackColor = UIColor.lightGray
        cell.SPB.progressColor = UIColor(red:0.00, green:0.73, blue:0.66, alpha:1.0)
        cell.SPB.setProgressWithAnimation(duration: 1.0, value: level2)
  
        return cell
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
