//
//  LetMeInViewController.swift
//  JoggTracker1
//
//  Created by Monya on 6/14/19.
//  Copyright © 2019 Zhegalik.Inc. All rights reserved.
//

import UIKit

class LetMeInViewController: UIViewController {

    @IBOutlet weak var letMeInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        letMeInButton.layer.cornerRadius = letMeInButton.frame.height / 2
        letMeInButton.layer.masksToBounds = true
        letMeInButton.layer.borderWidth = 3
        letMeInButton.layer.borderColor = UIColor(red: 0xE9, green: 0x90, blue: 0xF9).cgColor
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        let controller = UIViewController.getControllerFromStoryboard(withIdentifier: "MenuViewController") as! MenuViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func letMeInButtonClicked(_ sender: Any) {
        NetworkManager.request(target: JoggerApi.login(uuid: "hello"), success: { (response) in
            do {
                let json = try response.mapJSON() as? [String : Any]
                print(json!)
                guard let unwrapeJson = json else {
                    return
                }
                guard let response = unwrapeJson["response"] as? [String: Any] else {
                    return
                }
                
                User.shared.accessToken = response["access_token"] as? String
 
                let controller = UIViewController.getControllerFromStoryboard(withIdentifier: "JogsViewController") as! JogsViewController
                
                self.navigationController?.pushViewController(controller, animated: true)
            } catch {
                print("error")
            }
        }, error: { (error) in
            print(error)
        }) { (error) in
            print(error)
        }
    }
}


