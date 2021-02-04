//
//  ArrayExtensions.swift
//  ImageGallery
//
//  Created by Moban Michael on 04/02/2021.
//

import Foundation

extension Array where Element: Hashable {
    var uniques: Array {
        var uniqueItems = Array()
        var added = Set<Element>()
        for item in self {
            if !added.contains(item) {
                uniqueItems.append(item)
                added.insert(item)
            }
        }
        return uniqueItems
    }
}
