//
//  UIImageExtensions.swift
//  ImageGallery
//
//  Created by Moban Michael on 02/02/2021.
//

import Foundation
import UIKit

extension UIImage {
    var data: Data? {
        if let data = self.jpegData(compressionQuality: 1.0) {
            return data
        } else {
            return nil
        }
    }
}
