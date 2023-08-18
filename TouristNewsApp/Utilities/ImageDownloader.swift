//
//  ImageDownloader.swift
//  TouristNewsApp
//
//  Created by Martha Nashipae on 8/18/23.
//

import Foundation
import UIKit
class ImageDownloader {
    static func downloadImage(_ urlString: String, completion: ((_ _image: UIImage?, _ urlString: String?, _ binaryString: Data?) -> ())?) {
       guard let url = URL(string: urlString) else {
          completion?(nil, urlString, Data())
          return
      }
      URLSession.shared.dataTask(with: url) { (data, response,error) in
         if let error = error {
            print("error in downloading image: \(error)")
             
            completion?(nil, urlString, Data())
            return
         }
         guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
             
            completion?(nil, urlString, Data())
            return
         }
         if let data = data, let image = UIImage(data: data) {
             
            completion?(image, urlString, data)
            return
         }
         completion?(nil, urlString, Data())
      }.resume()
   }
    

}
