//
//  PicStore.swift
//  Mapic
//
//  Created by Jawaher Alagel on 12/7/20.
//

import Foundation
import UIKit

class PicStore {
    
    let cache = NSCache<NSNumber,UIImage>()
    let util = DispatchQueue.global(qos: .utility)
    
    func pictureURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
    
    func setPicture(_ image: UIImage, forKey key: NSNumber) {
        cache.setObject(image, forKey: key as NSNumber)
        
        let url = pictureURL(forKey: "\(key)")
        // turn image into JPEG data
        if let data = image.jpegData(compressionQuality: 0.5) {
            // write it to full URL
            try? data.write(to: url)
        }
    }
}
