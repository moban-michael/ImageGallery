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
    var title       : String
    var farm        : Int
    var server      : String
    var secret      : String
    var thumbnail   : Data?
    var mainImage   : Data?
    
    init (imageID: String, title:String, farm: Int, server: String, secret: String) {
        self.imageID = imageID
        self.title = title
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    
    static func ==(lhs: Image, rhs: Image) -> Bool {
        return lhs.imageID == rhs.imageID
    }
}
