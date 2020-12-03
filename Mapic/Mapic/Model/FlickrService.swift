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
    
    let baseURLString = "https://api.flickr.com/services/rest"
    let endPoint = "flickr.photos.search"
    let apiKey = "cc109f8c6934c41b7cf7baf0555c2ef1"
    
    func flickrURL(apiKey key: String, pinAnnotation annotation: Pin, numberOfPhotos number: Int) -> String {
        let url =  "\(baseURLString)/?method=\(endPoint)&api_key=\(apiKey)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=km&per_page=\(number)&format=json&nojsoncallback=1"
        return url
    }
    
    // MARK: - Helpers

    
}
