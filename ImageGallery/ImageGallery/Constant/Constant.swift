//
//  Constant.swift
//  ImageGallery
//
//  Created by Moban Michael on 31/01/2021.
//

import Foundation

class Constant {
    
    struct General {
        static let apiKey:String    = "f9cc014fa76b098f9e82f1c288379ea1"
    }
    
    struct Service {
        
        static let searchUrlPrefix :String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key="
        static let searchUrlSuffix :String = "&per_page=10&format=json&nojsoncallback=1"
        static let getSizes:String         = "https://www.flickr.com/services/api/flickr.photos.getSizes.html"

    }
    
}
