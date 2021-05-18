//
//  ProviderProtocol.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 15/05/2021.
//

protocol ProviderProtocol {
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable
}
