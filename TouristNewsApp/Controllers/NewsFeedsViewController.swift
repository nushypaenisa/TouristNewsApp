//
//  NewsFeedsViewController.swift
//  TouristNewsApp
//
//  Created by Martha Nashipae on 8/18/23.
//

import UIKit
import CoreData
import Network

class NewsFeedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentPage = 1
    var totalPages = 3301
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    var isConnected: Bool = false
    
    var loaderView: UIView?
    var tableView = UITableView()
    let refreshControl = UIRefreshControl()
    

    private var newsFeedList = [News]() {
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
        
        //tableView.separatorStyle = .none
        
        tableView.frame = view.bounds
        
        tableView.rowHeight = 220
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: Cells.newsCellName)
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        let rowNumber : Int = indexPath.row
//        
////         let vc = ViewTouristViewController()
////         vc.tourist = touristList[rowNumber]
////         self.navigationController?.pushViewController(vc, animated:true)
//        
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newsFeedList.count == 0 {
            tableView.setEmptyView(title: "You don't have any News Feeds.", message: "Your News Feeds will be in here.")
        }
        else {
            tableView.restore()
        }
      
        return newsFeedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.newsCellName) as! NewsCell

        let newsFeed = newsFeedList[indexPath.row]

        cell.titleLabel.text = newsFeed.title ?? "\(newsFeed.user?.name ?? "") Travels"
        cell.locationLabel.text = newsFeed.location
        cell.userNameLabel.text = newsFeed.user?.name ?? "Name"
        cell.createdAt.text = newsFeed.createdat
        cell.selectionStyle = .none
        
        if !isConnected{
            
            let image = UIImage(data: newsFeed.user?.data ?? Data())
            
            cell.userImageView.image = image
            
        }else{
            ImageDownloader.downloadImage( newsFeed.user?.profilepicture ?? "http://restapi.adequateshop.com/Media//Images/userimageicon.png") {
            image, urlString, binaryString in
               if let imageObject = image {
                  // performing UI operation on main thread
                  DispatchQueue.main.async {
                      cell.userImageView.image = imageObject
                  }
               }
            }
        }
        
//            if !isConnected{
//
//                let image = UIImage(data: multimedia.data ?? Data())
//                img.image = image
//                cell.containerImageView.addSubview(img)
//
//            }else{
        if !(newsFeed.multiMedia?.count == 0) {
                
            ImageDownloader.downloadImage( newsFeed.multiMedia?[0].url ?? "https://picsum.photos/300") {
                image, urlString, binaryString in
                   if let imageObject = image {
                      // performing UI operation on main thread
                      DispatchQueue.main.async {
                         // img.image = imageObject
                          cell.locationImage.image = imageObject //.addSubview(img)
                      }
                   }
                }
            }

           // }
        
//        for multimedia in newsFeed.multiMedia ?? [] {
//
//            let img = UIImageView()
//            img.contentMode = .scaleAspectFill // without this your image will shrink and looks ugly
//            img.translatesAutoresizingMaskIntoConstraints = false
//            img.layer.cornerRadius = 5
//            img.backgroundColor = UIColor(white: 0, alpha: 0.1)
//            img.clipsToBounds = true
//            img.widthAnchor.constraint(equalToConstant: 50).isActive = true
//            img.heightAnchor.constraint(equalToConstant:50).isActive = true
//           // img.topAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
//            //img.leadingAnchor.constraint(equalTo:cell.containerImageView.leadingAnchor).isActive = true
//            //img.topAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
//
//
//            if !isConnected{
//
//                let image = UIImage(data: multimedia.data ?? Data())
//                img.image = image
//                cell.containerImageView.addSubview(img)
//
//            }else{
//
//            ImageDownloader.downloadImage( multimedia.url ?? "http://restapi.adequateshop.com/Media//Images/userimageicon.png") {
//            image, urlString, binaryString in
//               if let imageObject = image {
//                  // performing UI operation on main thread
//                  DispatchQueue.main.async {
//                      img.image = imageObject
//                      cell.containerImageView.addSubview(img)
//                  }
//               }
//            }
//            }
//
//        }

        return cell

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == newsFeedList.count - 1, currentPage < totalPages {
            
                fetchData()
           
            }
    }
    
    
    
   

    @objc private func fetchData(completed: ((Bool) -> Void)? = nil) {
       
        
        NewsViewModel.shared.getNews(page: currentPage) { [weak self] result in
            switch result {
                
               case .success(let newsResp):
                
                    self?.totalPages = newsResp.totalPages!
                
                    self?.newsFeedList.append(contentsOf: newsResp.data)
                    
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
        
        self.newsFeedList = NewsViewModel.shared.fetchAllNewsFeeds() ?? []
        
     }
}



extension UITableView {
    func setEmptyView(title: String, message: String) {
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
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
