//
//  Main.swift
//  swifty_companion
//
//  Created by Kristine Sonu on 1/2/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit
import OAuthSwift
import SwiftyJSON
import Alamofire
import SVProgressHUD

//struct Skill {
//    var name: String
//    var level: Int
//    
//    init(_ dictionary: [String:Any]) {
//        self.name = dictionary["name"] as? String ?? ""
//        self.level = dictionary["level"] as? Int ?? 0
//    }
//}

class Main: UIViewController {

    var token = String()
    let url : String = "https://api.intra.42.fr"
    let uid : String = "55e390351e2370aadc5627d0d221678071b436b6c5aa0b22f1f913eb0f27babe"
    let secret : String = "160b77e99966b6eee87f225752194ea9f42a49351e472338b78e3690802a667b"
    let authLink : String = "/oauth/token"
    let userLink : String = "/v2/users/"
    var json : JSON?
    var tokenExp : Double = 0
    
    @IBOutlet weak var intraID: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchID(_ sender: UIButton) {
        searchButton.isEnabled = false
        let intra = intraID.text!
        if !intra.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            checkID(for: intra)
        } else {
            let alert = UIAlertController(title: "IntraID is Empty", message:
                "Enter Intra ID", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            searchButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        getToken()

        // Do any additional setup after loading the view, typically from a nib.
    }

    func getToken() {
        Alamofire.request(url + authLink, method: .post, parameters: ["grant_type" : "client_credentials", "client_id" : uid, "client_secret" : secret]).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Connection Validation Successful")
                self.json = JSON(response.value!)
                self.token = self.json!["access_token"].string!
                self.tokenExp = self.json!["created_at"].double! + self.json!["expires_in"].double!
            case .failure(let error):
                print(error)
            }
        }
    }

    func checkID(for login : String) {
        SVProgressHUD.show()
        
        if (NSDate().timeIntervalSince1970 > tokenExp) {
            self.getToken()
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(self.token)"]
        Alamofire.request(url + userLink + login, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                print("Success1")
                //parsing??
                self.json = JSON(response.value!)
                if (self.json?.isEmpty)! {
                    let alert = UIAlertController(title: "Intra ID not found", message:
                        "This ID is not valid.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.intraID.text = ""
                }
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "Profileinfo", sender: self)
                self.searchButton.isEnabled = true
                self.intraID.text = ""
                
            case .failure(let error):
                print(error)
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Invalid ID", message:
                    "Invalid", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.searchButton.isEnabled = true
                self.intraID.text = ""
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Profileinfo" {
            let new = segue.destination as! CustomBarController
            let destination = new.viewControllers?[0] as! PageOne
            let destination1 = new.viewControllers?[1] as! PageTwo
            let destination2 = new.viewControllers?[2] as! PageThree
            let destination2_2 = new.viewControllers?[2] as! PageThree
            destination.json = self.json
            destination1.json = self.json
            destination2.json = self.json
            destination2_2.sections.append(CpiscineSection(for: json!))
            destination2_2.sections.append(FTprojectSection(for: json!))
        }
    }
}
