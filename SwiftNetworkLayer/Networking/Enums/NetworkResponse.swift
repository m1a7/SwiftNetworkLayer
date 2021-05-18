//
//  NetworkResponse.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 16/05/2021.
//
enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}
