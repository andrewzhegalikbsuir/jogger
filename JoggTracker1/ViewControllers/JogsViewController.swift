//
//  JogsViewController.swift
//  JoggTracker1
//
//  Created by Monya on 6/14/19.
//  Copyright © 2019 Zhegalik.Inc. All rights reserved.
//

import UIKit

class JogsViewController: UIViewController {
    
    @IBOutlet weak var addNewJogButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var badEmotionImage: UIImageView!
    @IBOutlet weak var nothingIsThereLabel: UILabel!
    @IBOutlet weak var createYourJogFirstButton: UIButton!
    
    var jogs: [Jog] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "JogTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")

        createYourJogFirstButton.layer.cornerRadius = createYourJogFirstButton.frame.height / 2
        createYourJogFirstButton.layer.borderWidth = 3
        createYourJogFirstButton.layer.borderColor = UIColor(red: 0xE9, green: 0x90, blue: 0xF9).cgColor
        createYourJogFirstButton.layer.masksToBounds = true
        
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        let controller = UIViewController.getControllerFromStoryboard(withIdentifier: "MenuViewController") as! MenuViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func createYourJogFirstClicked(_ sender: Any) {
        let controller = UIViewController.getControllerFromStoryboard(withIdentifier: "AddNewJogViewController") as! AddNewJogViewController
        
        controller.jogDidCreate = {[unowned self] jog in
            self.jogs.append(jog)
            self.tableView.reloadData()
        }
        
        
        navigationController?.pushViewController(controller, animated: true)
        //present(controller, animated: true, completion: nil)
    }
}

extension JogsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(jogs.count)
        
        if jogs.count == 0 {
            self.badEmotionImage.isHidden = false
            self.tableView.isHidden = true
            self.nothingIsThereLabel.isHidden = false
            self.createYourJogFirstButton.isHidden = false
            self.addNewJogButton.isHidden = true
        } else {
            self.badEmotionImage.isHidden = true
            self.tableView.isHidden = false
            self.nothingIsThereLabel.isHidden = true
            self.createYourJogFirstButton.isHidden = true
            self.addNewJogButton.isHidden = false
        }
        
        return jogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! JogTableViewCell
        
        let jog = jogs[indexPath.row]
        cell.dateLabel.text = jog.date
        cell.distanceLabel.text = "\(jog.distance) km"
        cell.timeLabel.text = "\(jog.time) min"
        
        let speed = Int((jog.distance / Float(jog.time)) * 60)
        
        jog.speed = speed
        cell.speedLabel.text = "\(jog.speed) km/h"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jog = jogs[indexPath.row]
        
        let controller = UIViewController.getControllerFromStoryboard(withIdentifier: "AddNewJogViewController") as! AddNewJogViewController
        
        controller.isForUpdate = true
        controller.jogForUpdate = jog
        
        controller.jogDidUpdate = { [unowned self] jog in
            self.jogs[indexPath.row] = jog
            self.tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

