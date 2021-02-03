//
//  UrlUtlis.swift
//  ImageGallery
//
//  Created by Moban Michael on 02/02/2021.
//

import Foundation

class UrlUtlis {
    
    static func getSearchURL(for searchText:String) -> URL? {
        guard let escapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }
        let URLString = "\(Constant.Service.searchUrlPrefix + Constant.General.apiKey)&tags=\(escapedSearchText)\(Constant.Service.searchUrlSuffix)"
        return URL(string:URLString)
    }
    
    static func getImageURL(size: String, image:Image) -> URL? {
        if let url =  URL(string: "https://farm\(image.farm).staticflickr.com/\(image.server)/\(image.imageID)_\(image.secret)_\(size).jpg") { print(url)
            return url 
        }
        // TODO: check
        //https://farm6.staticflickr.com/5800/31456463045_5a0af4ddc8_q.jpg
        return nil
      }
    
}
