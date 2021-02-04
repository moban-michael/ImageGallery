//
//  Image.swift
//  ImageGallery
//
//  Created by Moban Michael on 31/01/2021.
//

import Foundation
import UIKit
import RealmSwift

class Image: Object, Codable  {
    
    @objc dynamic var imageID     : String = ""
    @objc dynamic var title       : String = ""
    @objc dynamic var farm        : Int = 0
    @objc dynamic var server      : String = ""
    @objc dynamic var secret      : String = ""
    @objc dynamic var thumbnail   : Data  = Data()
    @objc dynamic var mainImage   : Data  = Data()
    
    convenience init (imageID: String, title:String, farm: Int, server: String, secret: String) {
        self.init()
        self.imageID = imageID
        self.title = title
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let other = object as? Image {
            return self.imageID == other.imageID
        } else {
            return false
        }
    }
    
    override var hash: Int {
        return imageID.hashValue
    }
    
    
    static func ==(lhs: Image, rhs: Image) -> Bool {
        return lhs.imageID == rhs.imageID
    }
}
