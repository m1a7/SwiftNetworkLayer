//
//  DetailVM.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 16/05/2021.
//

import UIKit

/// ViewModel for DetailVC

class DetailVM: NSObject {

    private let model: Photo

    init(model: Photo) {
        self.model = model
    }
}

extension DetailVM {
  
    var albumID: String? {
        return "\(model.albumId)"
    }
    
    var id: String? {
        return "\(model.id)"
    }

    var title: String? {
        return "\(model.title)"
    }
    
    var url: String? {
        return "\(model.url)"
    }
    
    var thumbnailURLString: String? {
        return "\(model.thumbnailUrl)"
    }
}




