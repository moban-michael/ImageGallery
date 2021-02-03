//
//  UIViewExtensions.swift
//  ImageGallery
//
//  Created by Moban Michael on 03/02/2021.
//

import Foundation
import UIKit

extension UIView {
    
    func showToast(_ message : String, width: CGFloat) {
        onMainQueue {
            let boundFrame:CGRect = UIScreen.main.bounds
            let toastLabel = UILabel(frame: CGRect(x: (boundFrame.size.width - width)/2, y: boundFrame.size.height-120, width: width, height: 35))
            toastLabel.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
            toastLabel.numberOfLines = 3
            toastLabel.backgroundColor = UIColor.blue
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "OpenSans", size: 13.0)
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.addSubview(toastLabel)
            UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }

}
