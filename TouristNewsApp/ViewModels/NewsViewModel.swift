//
//  NewsViewModel.swift
//  newsFeedsNewsApp
//
//  Created by Martha Nashipae on 8/17/23.
//

import Foundation
import CoreData

struct NewsViewModel {
    
    static let shared = NewsViewModel()
  
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store Failed \(error)")
            }
        }
        return container
    }()
    
    
   //fetch News feeds from server
    func getNews(page: Int, completion: @escaping (Result<NewsResponse, APIError>) -> Void) {
        
        var components = URLComponents(string: Constants.newsUrl)!
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
           
        ]
        guard let url = components.url else {
            completion(.failure(.invalidUrl))
            return
        }
      
        let urlRequest = URLRequest(url: url, timeoutInterval: 10)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error  in
            //print(response)
            if error != nil {
                
                print("dataTask error: \(error!.localizedDescription)")
                completion(.failure(.failed(error: error!)))
                
            } else if let data = data {
                // Success request
                do {
                    // Decode json into array of News
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let newResponse = try decoder.decode(NewsResponse.self, from: data)
                    
                   
                    //save newsfeeds to local db
                    saveData(newsFeeds: newResponse.data)
                    
                    print("success")
                    completion(.success(newResponse))
                    
                } catch {
                    // Send error when decoding
                    print("decoding error")
                    completion(.failure(.errorDecode))
                }
            } else {
                print("unknown dataTask error")
                completion(.failure(.unknownError))
            }
        }
        .resume()
    }
    
    
    func saveData(newsFeeds: [News]) {
        
        let context = persistentContainer.viewContext
        
        for newsFeed in newsFeeds {
            
            let newsFeedsDB = NSEntityDescription.insertNewObject(forEntityName: "NewsFeedsDB", into: context) as! NewsFeedsDB
            
            newsFeedsDB.id = Int32(newsFeed.id!)
            newsFeedsDB.title = newsFeed.title
            newsFeedsDB.descriptions = newsFeed.description
            newsFeedsDB.location = newsFeed.location
            
            newsFeedsDB.commentCount = Int32(newsFeed.commentCount!)
           // newsFeedsDB.user = User()
            
//            let user: UserDB = UserDB()
//
//            user.userid = Int32(newsFeed.user?.userid ?? 0)
//            user.name = newsFeed.user?.name
//            user.profilepicture = newsFeed.user?.profilepicture

//            if newsFeed.user?.profilepicture  != nil{
//                ImageDownloader.downloadImage( newsFeed.user?.profilepicture ?? "http://restapi.adequateshop.com/Media//Images/userimageicon.png") {
//                image, urlString, binaryString in
//                   if let imageObject = binaryString {
//                      // performing UI operation on main thread
//                      DispatchQueue.main.async {
//                          user.profileImage = imageObject
//                      }
//                   }
//                }
//            }

           
   //         newsFeedsDB.user = user
            
            //newsFeedsDB.multimedia = newsFeed.multiMedia
            
            for media in newsFeed.multiMedia! {
                
//                let mediaItem: MultiMediaDB = MultiMediaDB()
//                mediaItem.id = Int32(media.id!)
//                mediaItem.descriptions = media.description
//                mediaItem.title = media.title
//                mediaItem.url = media.url
//                
                
                
//                ImageDownloader.downloadImage( media.url ?? "http://restapi.adequateshop.com/Media//Images/userimageicon.png") {
//                image, urlString, binaryString in
//                   if let imageObject = binaryString {
//                      // performing UI operation on main thread
//                      DispatchQueue.main.async {
//                          mediaItem.image = imageObject
//                      }
//
//                   }
//                }
              //  newsFeedsDB.addToMultimedias(mediaItem)
                
                
            }
            
            newsFeedsDB.location = newsFeed.location
            
            newsFeedsDB.createdat = newsFeed.createdat
            
            do{
                try context.save()
                print("News Saved")
            }catch let createError{
                print("Failed to  create: \(createError)")
                
            }
        }

        
        
    }
    
    func fetchAllNewsFeeds() -> [News]? {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NewsFeedsDB>(entityName: "NewsFeedsDB")
        
        do{
           let listNewsDB = try context.fetch(fetchRequest)
            
            var listItem: [News] = []
             
             for newsDb in listNewsDB {
                 
                 var news: News = News()
                 
                 news.id = Int(newsDb.id)
                 
                 news.title = newsDb.title
                 news.description = newsDb.descriptions
                 news.location = newsDb.location
                 news.createdat = newsDb.createdat
                 
                 
                 listItem.append(news)
                 
                 print("Data news fetched \(String(describing: news.id))")
                 
                 
             }

             return listItem
            
        }catch let fetchError{
            print("Failed to fetch newsFeeds \(fetchError)")
            
        }

        
        return nil
        
    }
    
 }

