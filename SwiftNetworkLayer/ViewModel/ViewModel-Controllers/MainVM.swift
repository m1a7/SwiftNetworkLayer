//
//  MainVM.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 16/05/2021.
//

import UIKit

/// ViewModel for MainTVC

class MainVM: NSObject {

    // Stores viewModels for cell for tableView of MainTVC
    var cellsViewModel = [PhotoCellVM]()

    // Service for getting data from the Internet
    private let sessionProvider = URLSessionProvider.shared 

    /**
     Retrieves the [Photo] array from the server and converts them to the [PhotoCellVM] array.
     
     - Parameters:
        - limit:  number of requested objects in the array
        - offset: request the following elements from the index x
        - completion: has an error parameter and an array of received ViewModels for cells
     */
    func getPhotos(limit:Int=20, offset:Int, completion: @escaping (NSError?, Array<PhotoCellVM>?)->Void) {
        sessionProvider.request(type: [Photo].self, service: PhotoService.photos(limit: limit, offset: offset)) {  [weak self] response in
         
            switch response {
            case let .success(photos):
                print(photos)
         
                // Creating ViewModels from Models
                if photos.isEmpty == false {
                    
                    var tempArrViewModels = [PhotoCellVM]()
                    for photo in photos {
                        let photoVM = PhotoCellVM(model: photo)
                        tempArrViewModels.append(photoVM)
                    }
                    // Add VM from temporary array to global array
                    self?.cellsViewModel += tempArrViewModels
                    completion(nil,tempArrViewModels)
                }else {
                    // Call completion to pass Error
                    let error = NSError(domain:"Empty array recievied from server", code:0, userInfo:nil)
                    completion(error,nil)
                }
                
            case let .failure(error):
                print(error)
                let error = NSError(domain:"\(error)", code:0, userInfo:nil)
                completion(error,nil)
            }
        }
    }
}
