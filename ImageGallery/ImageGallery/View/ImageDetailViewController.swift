//
//  ImageDetailViewController.swift
//  ImageGallery
//
//  Created by Moban Michael on 03/02/2021.
//

import Foundation
import UIKit
import RxSwift

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var image:Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    //MARK: UI
    fileprivate func setUpUI(){
        if let currentImage = image{
            self.title = currentImage.title
            self.label.text = currentImage.imageID
            self.imageView.image = currentImage.mainImage.image
        }
    }
    
    //MARK: Action
    @IBAction func doneButtonTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
