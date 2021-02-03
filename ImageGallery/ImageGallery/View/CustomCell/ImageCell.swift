//
//  ImageCell.swift
//  ImageGallery
//
//  Created by Moban Michael on 31/01/2021.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.layer.borderColor  = UIColor.black.cgColor
        self.layer.borderWidth  = 1
        self.layer.cornerRadius = 8
    }
    
}
