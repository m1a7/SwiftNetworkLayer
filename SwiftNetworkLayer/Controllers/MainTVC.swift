//
//  MainTVC.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 16/05/2021.
//

import UIKit

/// 📱 Displays a list of photos received from jsonplaceholder.typicode.com/photos

final class MainTVC: UITableViewController {

    // MARK: - UI
    
    // The view that is displayed when the lower border of the screen is reached
    @IBOutlet private weak var footerView: UIView?
    // Allows you to show the user that the download is currently in progress
    @IBOutlet private weak var footerLoader: UIActivityIndicatorView?
    // Allows you to display the download status
    @IBOutlet private weak var footerLabel: UILabel?
    
    // MARK: - User Data
    
    // Contains logic for interacting with different services (e.g. NetworkLayer)
    var viewModel = MainVM()
    // Auxiliary variable, helps to avoid duplicate network requests
    var isLoading = false

    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getPhotos()
    }


    // MARK: - Logic
    
    //  Calls the ViewModel to get data from the server.
    //  ViewModel returns viewModels for table cells.
    func getPhotos()
    {
        viewModel.getPhotos(offset:viewModel.cellsViewModel.count){ (error: NSError?, models:Array<PhotoCellVM>?) in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                if (error != nil) {
                    print("MainTVC.getPhotos().completion has been error \(String(describing: error))")
                }
                self?.isLoading = false
                self?.footerLoader?.stopAnimating()
                self?.footerView?.isHidden = true
              }
        }
    }
    
}


//MARK: - UITableViewDataSource
extension MainTVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsViewModel.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.viewModel = viewModel.cellsViewModel[indexPath.row]
        return cell
    }
}


//MARK: - UITableViewDelegate
extension MainTVC {
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Pass to Detail Controller
        let cellViewModel = viewModel.cellsViewModel[indexPath.row]
        let detailVM = DetailVM.init(model:cellViewModel.model)
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC   : DetailVC = storyboard.instantiateViewController(identifier: "DetailVC")
        
        if (self.navigationController != nil) {
            detailVC.viewModel = detailVM
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


// MARK: -  UIScrollViewDelegate
extension MainTVC {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        //let additionalOffset = -(UIApplication.shared.statusBarFrame.height)
        let additionalOffset = -(view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
                
        if deltaOffset < additionalOffset && !isLoading && viewModel.cellsViewModel.count > 0 {
            isLoading = true
            footerView?.isHidden = false
            footerLoader?.startAnimating()
            getPhotos()
        }
    }
}


//MARK: Private extension - used to setuping UI
private extension MainTVC{
  
    // Pre-configures the interface
    func setupUI() {
        tableView.tableFooterView = footerView
        footerLabel?.font = UIFont(name: "SFProText-Regular", size: 13)
        footerLabel?.textColor = UIColor(red: 0.56, green: 0.58, blue: 0.6, alpha: 1)
    }
}

