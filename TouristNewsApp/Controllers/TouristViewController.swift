//
//  TouristViewController.swift
//  TouristNewsApp
//
//  Created by Martha Nashipae on 8/17/23.
//

import UIKit
import CoreData
import Network


class TouristViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentPage = 1
    var totalPages = 3301
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    var isConnected: Bool = false
    
    var loaderView: UIView?
    var tableView = UITableView()
    let refreshControl = UIRefreshControl()
    

    private var touristList = [Tourist]() {
            didSet {
                DispatchQueue.main.async { [weak self] in
                    self?.removeActivityIndicator()
                    self?.tableView.reloadData()
                }
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                self.isConnected = true
            } else {
                print("There's no internet connection.")
                self.isConnected = false
            }
        }

        monitor.start(queue: queue)
        
        // Do any additional setup after loading the view.
        displayActivityIndicator(onView: self.view)
        
        if isConnected {
            
            fetchData()
            
        }else {
            
            getDataFromDB()
            
        }
           
        setUpTableView()
        
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    func displayActivityIndicator(onView : UIView) {
        let containerView = UIView.init(frame: onView.bounds)
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = containerView.center
        DispatchQueue.main.async {
            containerView.addSubview(activityIndicator)
            onView.addSubview(containerView)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        loaderView = containerView
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async {
            self.loaderView?.removeFromSuperview()
            self.loaderView = nil
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func setUpTableView(){
        
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        
        tableView.frame = view.bounds
        
        tableView.rowHeight = 100
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.register(TouristCell.self, forCellReuseIdentifier: Cells.touristCellName)
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if touristList.count == 0 {
            
            tableView.setEmptyViewItem(title: "You don't have any Tourist.", message: "Your Tourist will be in here.")
        }
        else {
            tableView.restoreItem()
        }
        return touristList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.touristCellName) as! TouristCell

        let tourist = touristList[indexPath.row]

        cell.nameLabel.text = tourist.touristName
        cell.emailLabel.text = tourist.touristEmail
        cell.locationLabel.text = tourist.touristLocation
        
        if !isConnected{
            
            let image = UIImage(data: tourist.data ?? Data())
            
            cell.profileImageView.image = image
            
        }else{
            
            ImageDownloader.downloadImage( tourist.touristProfilepicture ?? "http://restapi.adequateshop.com/Media//Images/userimageicon.png") {
            image, urlString, binaryString in
               if let imageObject = image {
                  // performing UI operation on main thread
                  DispatchQueue.main.async {
                      cell.profileImageView.image = imageObject
                  }
               }
            }
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == touristList.count - 1, currentPage < totalPages {
            
                fetchData()
           
            }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let rowNumber : Int = indexPath.row
        
         let vc = ViewTouristViewController()
         vc.tourist = touristList[rowNumber]
         self.navigationController?.pushViewController(vc, animated:true)
        
    }
    
   

    //fetch user data
    @objc private func fetchData(completed: ((Bool) -> Void)? = nil) {
       
        
        TouristViewModel.shared.getTourist(page: currentPage) { [weak self] result in
            switch result {
                
               case .success(let touristRes):
                
                    self?.totalPages = touristRes.totalPages!
                
                    self?.touristList.append(contentsOf: touristRes.data)
                    
                    completed?(true)
                
                case .failure(let error):
                    
                    print(error.localizedDescription)
                   
                    completed?(false)
                }
            }
        
        currentPage += 1
        refreshControl.endRefreshing()
       
    }
    
    func getDataFromDB(){
        
        self.touristList = TouristViewModel.shared.fetchAllTourist() ?? []
        
     }
}



extension UITableView {
    func setEmptyViewItem(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
       
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
       
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        titleLabel.text = title
        
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
        }
    
    func restoreItem() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
