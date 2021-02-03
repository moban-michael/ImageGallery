//
//  Image.swift
//  ImageGallery
//
//  Created by Moban Michael on 31/01/2021.
//

import Foundation
import UIKit

struct Image: Codable, Equatable  {
    
    var imageID     : String
    var farm        : Int
    var server      : String
    var secret      : String
    var thumbnail   : Data?
    var mainImage   : Data?
    
    init (imageID: String, farm: Int, server: String, secret: String) {
      self.imageID = imageID
      self.farm = farm
      self.server = server
      self.secret = secret
    }
    
    static func ==(lhs: Image, rhs: Image) -> Bool {
        return lhs.imageID == rhs.imageID
    }
    
    func getMaxSize(of size:CGSize) -> CGSize {
        guard let thumbnail = thumbnail?.image else { return size }
        var maxSize         = size
        let aspectRatio     = thumbnail.size.width / thumbnail.size.height
        maxSize.height      = maxSize.width / aspectRatio
        
        if maxSize.height > size.height {
            maxSize.height  = size.height
            maxSize.width   = size.height * aspectRatio
        }
        return maxSize
    }
}
