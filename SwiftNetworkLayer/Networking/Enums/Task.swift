//
//  Task.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 15/05/2021.
//

typealias Parameters = [String: Any]

enum Task {
    case requestPlain
    case requestParameters(Parameters)
}
