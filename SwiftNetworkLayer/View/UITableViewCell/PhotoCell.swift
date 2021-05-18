//
//  PhotoCell.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 16/05/2021.
//

import UIKit

class PhotoCell: UITableViewCell {

    // MARK: - UI
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    // MARK: - User Data
    var viewModel: PhotoCellVM? {
        didSet{
            bindDataFrom(viewModel: viewModel)
        }
    }

    // Inserts data into the UI 
    func bindDataFrom(viewModel: PhotoCellVM?) {
                
        guard let viewModel = viewModel else {
            return
        }

        if let title = viewModel.title {
            titleLbl!.text = title
        }
        
        if let imgURL = viewModel.thumbnailURLString {
            // download imge
            ImageService.shared.get(urlString: imgURL,round:true){ [weak self] (image: UIImage?) in
                if let cahcedImage = image{
                    self?.imgView.image = cahcedImage
                }
            }
        }
    }
}
