//
//  MenuViewController.swift
//  JoggTracker1
//
//  Created by Monya on 6/14/19.
//  Copyright © 2019 Zhegalik.Inc. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var jogsButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var contactUsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jogsButton.setTitleColor(UIColor(rgb: 0x7ED321), for: .highlighted)
        infoButton.setTitleColor(UIColor(rgb: 0x7ED321), for: .highlighted)
        contactUsButton.setTitleColor(UIColor(rgb: 0x7ED321), for: .highlighted)
    }
    
    @IBAction func jogsButtonClicked(_ sender: Any) {
        let controller = UIViewController.getControllerFromStoryboard(withIdentifier: "JogsViewController") as! JogsViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func infoButtonClicked(_ sender: Any) {
        let controller = UIViewController.getControllerFromStoryboard(withIdentifier: "InfoViewController") as! InfoViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
