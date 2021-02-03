//
//  GeneralServiceManager.swift
//  ImageGallery
//
//  Created by Moban Michael on 02/02/2021.
//

import Foundation
import RxCocoa
import RxSwift

enum Error: Swift.Error {
    case unknown
    case invalidUrl
    case failed
    case parseError
}

class GeneralServiceManager {
    
    func callWebService(url:URL) -> Observable<(Data)> {
        
        return Observable<(Data)>.create { observer in
            
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
                if error != nil {
                    observer.onError(Error.failed)
                    return
                }
                
                guard let _ = response as? HTTPURLResponse, let data = data else {
                    observer.onError(Error.unknown)
                    return
                }
                
                do{
                    guard let resultsDictionary = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject], let status = resultsDictionary["stat"] as? String else {
                        observer.onError(Error.parseError)
                        return
                    }
                    
                    switch (status) {
                    case "ok":
                        observer.onNext(data)
                    case "fail":
                        observer.onError(Error.failed)
                        return
                    default:
                        observer.onError(Error.unknown)
                        return
                    }
                }catch{
                    observer.onError(Error.unknown)
                }
                
                
            }.resume()
            
            return Disposables.create {
                
            }
        }
    }
}
