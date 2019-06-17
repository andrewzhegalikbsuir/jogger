//
//  NetworkManager.swift
//  JoggTracker1
//
//  Created by Monya on 6/14/19.
//  Copyright © 2019 Zhegalik.Inc. All rights reserved.
//

import Foundation
import Moya

struct NetworkManager {
    
    static let provider = MoyaProvider<JoggerApi>()
    
    static func request(target: JoggerApi, success successCallback: @escaping(Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping(MoyaError) -> Void) {
        
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                    let error = NSError(domain:"com.error", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
}
