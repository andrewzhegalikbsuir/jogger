//
//  AddNewJogViewController.swift
//  JoggTracker1
//
//  Created by Monya on 6/14/19.
//  Copyright © 2019 Zhegalik.Inc. All rights reserved.
//

import UIKit

class AddNewJogViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    
    @IBOutlet weak var newJogView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    var viewController: JogsViewController?
    
    var jogDidCreate: ((Jog) -> (Void))?
    var jogDidUpdate: ((Jog) -> (Void))?
    
    var isForUpdate: Bool = false
    var jogForUpdate: Jog?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newJogView.layer.cornerRadius = 30
        newJogView.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        saveButton.layer.masksToBounds = true
        saveButton.layer.borderWidth = 2
        saveButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        let controller = UIViewController.getControllerFromStoryboard(withIdentifier: "MenuViewController") as! MenuViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if isForUpdate {
            guard let jog = jogForUpdate else {
                return
            }
            
            
        } else {
            let jog = Jog()
            
            if let distance = distanceTextField.text {
                if let floatDistance = Float(distance) {
                    jog.distance = floatDistance
                }
            }
            
            if let time = timeTextField.text {
                if let intTime = Int(time) {
                    jog.time = intTime
                }
            }
            
            if let date = dateTextField.text {
                jog.date = date
            }
            
            
            NetworkManager.request(target: JoggerApi.addNewJog(access_token: User.shared.accessToken!, date: jog.date, time: jog.time, distance: jog.distance), success: { (response) in
                do {
                    let json = try response.mapJSON() as? [String : Any]
                    
                    guard let unwrapeJson = json else {
                        return
                    }
                    guard let response = unwrapeJson["response"] as? [String: Any] else {
                        return
                    }
                    
                    guard let jogId = response["id"] as? Int else {
                        return
                    }
                    print(jogId)
                    jog.jogId = jogId
                    
                    guard let userId = response["user_id"] as? Int else {
                        return
                    }
                    
                    jog.userId = userId
                    
                    if let action = self.jogDidCreate {
                        action(jog)
                    }
                    self.navigationController?.popViewController(animated: true)
                    
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
}
