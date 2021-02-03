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
    
    //MARK: Here I am using completion handler to share how I use it
    func callWebService(url:URL, completion: @escaping (Response<Data>) -> Void) {
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                completion(Response.error(.unknown))
                return
            }
            
            guard let _ = response as? HTTPURLResponse, let data = data else {
                completion(Response.error(.unknown))
                return
            }
            
            do{
                guard let resultsDictionary = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject], let status = resultsDictionary["stat"] as? String else {
                    completion(Response.error(.parseError))
                    return
                }
                
                switch (status) {
                case "ok":
                    completion(Response.success(data))
                case "fail":
                    completion(Response.error(.failed))
                    return
                default:
                    completion(Response.error(.unknown))
                    return
                }
            }catch{
                completion(Response.error(.unknown))
            }
        }.resume()
    }
}
