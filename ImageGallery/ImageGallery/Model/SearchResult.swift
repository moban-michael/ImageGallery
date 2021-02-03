//
//  SearchResult.swift
//  ImageGallery
//
//  Created by Moban Michael on 01/02/2021.
//

import Foundation

struct SearchResult: Codable  {
    
    var searchText  : String
    var results     : [Image]
}
