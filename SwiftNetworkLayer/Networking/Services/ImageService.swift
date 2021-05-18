//
//  ImageService.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 17/05/2021.
//

import UIKit

final class ImageService {
   
    static let shared = ImageService()

    let session: URLSession
    let MB = 1024 * 1024
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 50 * MB, diskCapacity: 50 * MB, diskPath: "images")
        configuration.httpMaximumConnectionsPerHost = 10
        session = URLSession(configuration: configuration)
    }

    public func get(urlString: String, round: Bool = false, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.sync {
                completion(nil);
            }
            return
        }
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                var image = UIImage(data: data)
                if round {
                    image = image?.roundedImage
                }
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
