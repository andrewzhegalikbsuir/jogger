//
//  User.swift
//  JoggTracker1
//
//  Created by Monya on 6/14/19.
//  Copyright © 2019 Zhegalik.Inc. All rights reserved.
//

import Foundation


class User {
    
    static let shared = User()
    
    var accessToken:            String? {
        didSet{
            UserDefaults.standard.set(accessToken, forKey: "auth_token")
            UserDefaults.standard.synchronize()
        }
    }
}
