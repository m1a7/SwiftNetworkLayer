//
//  PhotoService.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 16/05/2021.
//

import Foundation

enum PhotoService: ServiceProtocol {
    
    case photos(limit: Int, offset: Int)
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        switch self {
        case .photos:
            return "photos"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .photos(limit, offset):
        let parameters = ["_limit": limit, "_start" : offset]
            return .requestParameters(parameters)
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}

