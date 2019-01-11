//
//  PageOne.swift
//  swifty_companion
//
//  Created by Kristine Sonu on 1/4/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit
import SwiftyJSON


class PageOne: UIViewController {

    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var correction: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var progressLevel: Float = 0.00

    let scrollView = UIScrollView()
    var json: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let LogIn = json!["login"].string {
            login.text = LogIn
        }
        else {
            login.text = "Unknown"
        }
        if let name = json!["displayname"].string {
            fullname.text = name
        }
        else {
            fullname.text = "Unknown"
        }
        if let l = json!["location"].string {
            location.text = l
        }
        else {
            location.text = "Unavailable"
        }
        if let e = json!["email"].string {
            email.text = e
        }
        else {
            email.text = "Unknown"
        }
        if let m = json!["phone"].string {
                mobile.text = m
        }
        else {
            mobile.text = "Unknown"
        }
        if let w = json!["wallet"].int {
            wallet.text = String(w)
        }
        else {
            wallet.text = "Unknown"
        }
        if let c = json!["correction_point"].int {
            correction.text = String(c)
        }
        else {
            correction.text = "Unknown"
        }
        
        progressBar()
        profilePicture()

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
                profilePic.layer.borderWidth = 5
                profilePic.layer.borderColor = UIColor.white.cgColor
                profilePic.clipsToBounds = true
                //profilePic.layer.masksToBounds = true
            } else {
                print("error")}
        }
    }
    
    func progressBar() {

        progressView.transform = progressView.transform.scaledBy(x: 1, y: 5)
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.setProgress(progressLevel, animated: false)
        perform(#selector(updateProgress), with: nil)
    }
    @objc func updateProgress() {
        let normalize: ((Float) -> Float) = { (input) in
            return roundf(input * 100) / 100
        }
        let maxlevel = json!["cursus_users"][0]["level"].float
        progressLevel = progressLevel + 0.11
        progressView.progress = (progressLevel) / 21

        level.text = "level : " + "\(normalize(maxlevel!))"
        
        if normalize(progressLevel) <= normalize(maxlevel!) {
            perform(#selector(updateProgress), with:nil, afterDelay: 0.03)
        } else {
            print("Stop")
            progressLevel = 0.0
        }
    }
}

