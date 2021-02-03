//
//  DataExtensions.swift
//  ImageGallery
//
//  Created by Moban Michael on 02/02/2021.
//

import Foundation
import UIKit

extension Data {
    var image: UIImage? {
        if let image = UIImage(data: self) {
            return image
        } else {
            return nil
        }
    }
}
