//
//  TouristViewModel.swift
//  TouristTouristApp
//
//  Created by Martha Nashipae on 8/17/23.
//

import Foundation
import CoreData


struct TouristViewModel {
    
    static let shared = TouristViewModel()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store Failed \(error)")
            }
        }
        return container
    }()
    
   
    //Fetch Data from server
    func getTourist(page: Int, completion: @escaping (Result<TouristResponse, APIError>) -> Void) {
       
        var components = URLComponents(string: Constants.touristUrl)!
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
        ]
        guard let url = components.url else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let urlRequest = URLRequest(url: url, timeoutInterval: 10)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error  in
            if error != nil {
                print("dataTask error: \(error!.localizedDescription)")
                completion(.failure(.failed(error: error!)))
            } else if let data = data {
                // Success request
                do {
                    // Decode json into array of Tourist
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let newResponse = try decoder.decode(TouristResponse.self, from: data)
                    saveData(tourists: newResponse.data)
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
    
    //Save tourist data to coredata
    
    func saveData(tourists: [Tourist]) {
        
        let context = persistentContainer.viewContext
        for tourist in tourists {
            let touristDB = NSEntityDescription.insertNewObject(forEntityName: "TouristDB", into: context) as! TouristDB

            touristDB.id = Int32(tourist.id!)
            touristDB.touristName = tourist.touristName
            touristDB.touristEmail = tourist.touristEmail
            touristDB.touristLocation = tourist.touristLocation
            touristDB.createdat = tourist.createdat
            ImageDownloader.downloadImage( tourist.touristProfilepicture ?? "http://restapi.adequateshop.com/Media//Images/userimageicon.png") {
            image, urlString, binaryString in
               if let imageObject = binaryString {
                  // performing UI operation on main thread
                  DispatchQueue.main.async {
                      touristDB.profilePic = imageObject
                  }
                   
               }
            }

            do{
                try context.save()
                print("Data saved")
                //return touristDB
            }catch let createError{
                print("Failed to  create: \(createError)")

            }

        }

        //return nil

    }

    func fetchAllTourist() -> [Tourist]? {

        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<TouristDB>(entityName: "TouristDB")

        do{
           let listTouristDB = try context.fetch(fetchRequest)
           var listItem: [Tourist] = []
            
            for touristDb in listTouristDB {
                
                var tourist: Tourist = Tourist()
                tourist.id = Int(touristDb.id)
                tourist.touristName = touristDb.touristName
                tourist.touristEmail = touristDb.touristEmail
                tourist.touristLocation = touristDb.touristLocation
                tourist.createdat = touristDb.createdat
                tourist.data = touristDb.profilePic
                
                
                listItem.append(tourist)
                print("Data fetched \(touristDb.id)")
                
                
            }

            return listItem

        }catch let fetchError{
            
            print("Failed to fetch tourist \(fetchError)")

        }


        return nil

    }
    
    
 }

