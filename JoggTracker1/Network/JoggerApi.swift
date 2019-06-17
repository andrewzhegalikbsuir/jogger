//
//  JoggerApi.swift
//  JoggTracker1
//
//  Created by Monya on 6/14/19.
//  Copyright © 2019 Zhegalik.Inc. All rights reserved.
//

import Foundation
import Moya

enum JoggerApi {
    case login(uuid: String)
    case addNewJog(access_token: String, date: String, time: Int, distance: Float)
    case updateJog(access_token: String, date: String, time: Int, distance: Float, jog_id: Int, user_id: String)
    case getListOfJogs(access_token: String)
    case sendFeedback(topic_id: Int, text: String)
}

extension JoggerApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://jogtracker.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/api/v1/auth/uuidLogin"
        case .addNewJog:
            return "/api/v1/data/jog"
        case .updateJog:
            return "/api/v1/data/jog"
        case .sendFeedback:
            return "/api/v1/feedback/send"
        case .getListOfJogs:
            return "/api/v1/data/sync"
        }
    }

    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let uuid):
            var parameters = [String: Any]()
            parameters["uuid"] = uuid
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .addNewJog(let access_token, let date, let time, let distance):
            var parameters = [String: Any]()
            parameters["access_token"] = access_token
            parameters["date"] = date
            parameters["time"] = time
            parameters["distance"] = distance
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .updateJog(let access_token, let date, let time, let distance, let jog_id, let user_id):
            var parameters = [String: Any]()
            parameters["access_token"] = access_token
            parameters["date"] = date
            parameters["time"] = time
            parameters["distance"] = distance
            parameters["jog_id"] = jog_id
            parameters["user_id"] = user_id
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .sendFeedback(let topic_id, let text):
            var parameters = [String: Any]()
            parameters["topic_id"] = topic_id
            parameters["text"] = text
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getListOfJogs(let access_token):
            var parameters = [String: Any]()
            parameters["access_token"] = access_token
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .addNewJog:
            return .post
        case .updateJog:
            return .put
        case .sendFeedback:
            return .post
        case .getListOfJogs:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login:
            return ["Content-Type": "application/json"]
        case .addNewJog:
            return ["Content-Type": "application/json"]
        case .updateJog:
            return ["Content-Type": "application/json"]
        case .sendFeedback:
            return ["Content-Type": "application/json"]
        case .getListOfJogs:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
