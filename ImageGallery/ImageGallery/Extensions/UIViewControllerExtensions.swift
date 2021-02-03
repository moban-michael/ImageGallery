//
//  UIViewControllerExtensions.swift
//  ImageGallery
//
//  Created by Moban Michael on 31/01/2021.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showProgress(with title: String? = nil) {
        onMainQueue {
            let progress = MBProgressHUD.showAdded(to: self.view, animated: true)
            progress.label.text = title ?? "Loading..."
        }
    }
    
    func hideProgress() {
        onMainQueue {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
