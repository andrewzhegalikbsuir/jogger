//
//  InfoViewController.swift
//  JoggTracker1
//
//  Created by Monya on 6/14/19.
//  Copyright © 2019 Zhegalik.Inc. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func menuButtonClicked(_ sender: Any) {
        let controller = UIViewController.getControllerFromStoryboard(withIdentifier: "MenuViewController") as! MenuViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
