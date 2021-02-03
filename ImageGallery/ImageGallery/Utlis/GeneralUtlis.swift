//
//  GeneralUtlis.swift
//  ImageGallery
//
//  Created by Moban Michael on 03/02/2021.
//

import Foundation

func onMainQueue(_ closure: @escaping () -> Void) {
    DispatchQueue.main.async {
        closure()
    }
}

class GeneralUtlis {
    
}
