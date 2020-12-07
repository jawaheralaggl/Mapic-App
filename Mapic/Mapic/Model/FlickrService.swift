//
//  FlickrService.swift
//  Mapic
//
//  Created by Jawaher Alagel on 12/3/20.
//

import Foundation
import Alamofire
import AlamofireImage

class FlickrService {
    static let shared = FlickrService()
    
    // MARK: - Properties
    
    var picUrlArray = [String]()
    var pictureArray = [UIImage]()
    var picTitleArray = [String]()
    
    let baseURLString = "https://api.flickr.com/services/rest"
    let endPoint = "flickr.photos.search"
    let apiKey = "cc109f8c6934c41b7cf7baf0555c2ef1"
    
    func flickrURL(apiKey key: String, pinAnnotation annotation: Pin, numberOfPhotos number: Int) -> String {
        let url =  "\(baseURLString)/?method=\(endPoint)&api_key=\(apiKey)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=km&per_page=\(number)&format=json&nojsoncallback=1"
        return url
    }
    
    // MARK: - Helpers
    
    func fetchUrls(forAnnotation annotation: Pin, handler: @escaping (_ status: Bool) -> ()) {
        picUrlArray = []
        
        // make a request..
        AF.request(flickrURL(apiKey: apiKey, pinAnnotation: annotation, numberOfPhotos: 50)).responseJSON { (response) in
            
            guard let jsonResponse = response.value as? Dictionary<String, AnyObject> else { return }
            
            let picDictionary = jsonResponse["photos"] as! Dictionary<String, AnyObject>
            let picsDictionaryArray = picDictionary["photo"] as! [Dictionary<String, AnyObject>]
            
            // loop over photos in the array
            for pic in picsDictionaryArray {
                let url = "https://live.staticflickr.com/\(pic["server"]!)/\(pic["id"]!)_\(pic["secret"]!)_b_d.jpg"
                self.picUrlArray.append(url)
                
                // add images title in new array
                if pic["title"] == nil {
                    self.picTitleArray.append("")
                }else{
                    self.picTitleArray.append(pic["title"] as! String)
                }
            }
            DispatchQueue.main.async {
                handler(true)
            }
        }
    }
    
    func fetchImages(handler: @escaping (_ status: Bool) -> ()) {
        pictureArray = []
        
        // loop over photos URL in the array
        for url in picUrlArray {
            AF.request(url).responseImage { response in
                
                guard let imageResponse = response.value else { return }
                self.pictureArray.append(imageResponse)
                print("\(self.pictureArray.count)/50 IMAGES DOWNLOADED")
                
                // check if all pictures has been downloaded successfully
                if self.pictureArray.count == self.picUrlArray.count {
                    DispatchQueue.main.async {
                        handler(true)
                    }
                }
            }
        }
        
    }
    
    
}
