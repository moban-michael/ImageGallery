//
//  ImageServiceManager.swift
//  ImageGallery
//
//  Created by Moban Michael on 01/02/2021.
//

import Foundation
import RxCocoa
import RxSwift

class ImageServiceManager {
    
    let generalServiceManager   = GeneralServiceManager()
    private let disposeBag      = DisposeBag()
    
    func searchImage(for searchText: String) -> Observable<(SearchResult)> {
        
        return Observable<(SearchResult)>.create { observer in
            
            if let url = UrlUtlis.getSearchURL(for: searchText){
                
                self.generalServiceManager.callWebService(url: url) { response in
                    
                    do {
                        switch response {
                        case .error(let error) :
                            print("Server Error response: \(error)")
                            observer.onError(Error.failed)
                        case .success(let data):
                            
                            let json = try JSONSerialization.jsonObject(with: data) as? [String: AnyObject]
                            guard let photos = json!["photos"] as? [String: AnyObject], let photo = photos["photo"] as? [[String: AnyObject]] else {
                                observer.onError(Error.parseError)
                                return
                            }
                            
                            let images: [Image] = photo.compactMap { image in

                                guard let imageID = image["id"] as? String,let title = image["title"] as? String, let farm = image["farm"] as? Int , let server = image["server"] as? String , let secret = image["secret"] as? String else { return nil }
                                
                                var image = Image(imageID: imageID, title: title,farm: farm, server: server, secret: secret)
                                guard let url = UrlUtlis.getImageURL(size: "m", image: image), let imageData = try? Data(contentsOf: url as URL) else { return nil }
                                
                                if let largeImage = UIImage(data: imageData) {
                                    image.mainImage = largeImage.data!
                                    return image
                                } else {
                                    return nil
                                }
                            }
                            let searchResults = SearchResult(searchText: searchText, results: images)
                            observer.onNext(searchResults)
                        }
                    } catch  {
                        observer.onError(Error.parseError)
                    }
                }
            }
            return Disposables.create {
                
            }
        }
    }
    
    
    func getLargeImage(image:Image) -> Observable<(Image)> {
        
        return Observable<(Image)>.create { observer in
            
            if let imageUrl = UrlUtlis.getImageURL(size: "b", image: image){
                
                self.generalServiceManager.callWebService(url: imageUrl){ response in
                    
                    switch response {
                    case .error(let error) :
                        observer.onError(Error.failed)
                    case .success(let data):
                        
                        var largeImage = image
                        largeImage.mainImage = (UIImage(data: data)?.data)!
                        observer.onNext(largeImage)
                    }
                }
                
            } else {
                observer.onError(Error.invalidUrl)
            }
            return Disposables.create {
                
            }
        }
    }
}
