//
//  Photo.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 16/05/2021.
//

import Foundation


struct Photo: Codable {
    let albumId : Int
    let id      : Int
    let title   : String
    let url     : String
    let thumbnailUrl : String
}
