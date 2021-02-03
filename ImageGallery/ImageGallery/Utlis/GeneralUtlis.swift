//
//  GeneralUtlis.swift
//  ImageGallery
//
//  Created by Moban Michael on 03/02/2021.
//

import Foundation
import Alamofire

func onMainQueue(_ closure: @escaping () -> Void) {
    DispatchQueue.main.async {
        closure()
    }
}

class GeneralUtlis {
    
    static func isNetworkConnectionAvailable() -> Bool {
        
        if (NetworkReachabilityManager()?.isReachable)!{
            return true
        }else{
            return false
        }
    }
}
