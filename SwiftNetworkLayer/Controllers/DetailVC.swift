//
//  DetailVC.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 16/05/2021.
//

import UIKit

/// 🔍 🏞 Screen for viewing a specific photo card

final class DetailVC: UIViewController {

    // MARK: - UI
    
    // Large image in the center of the screen
    @IBOutlet weak var imageView: UIImageView!
    // Caption under the picture
    @IBOutlet weak var label: UILabel!
    
    // MARK: - User Data

    // Contains logic for interacting with different services (e.g. NetworkLayer)
    var viewModel : DetailVM?
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 0.3) {
            self.bindData()
        }
    }
}


//MARK: Private extension - used to setuping UI
private extension DetailVC{
  
    // Inserts data into the UI 
    func bindData() {
        
        guard viewModel != nil else {
            return
        }

        if let title = viewModel?.title {
            label!.text = title
        }
        
        if let imgURL = viewModel?.url {
            // download imge
            ImageService.shared.get(urlString: imgURL,round:true){ [weak self] (image: UIImage?) in
                if let cahcedImage = image{
                    self?.imageView.image = cahcedImage
                }
            }
        }
    }
}

