//
//  ImageListDataManager.swift
//  ImageGallery
//
//  Created by Moban Michael on 03/02/2021.
//

import Foundation
import RxCocoa
import RxSwift

class ImageListDataManager {
    
    private let disposeBag = DisposeBag()
    
    func saveImagesIntoDB(text:String, images:[Image]) -> Observable<(Bool)> {
        
        return Observable<(Bool)>.create { observer in
            
            // TODO: store in Database
            observer.onNext(true)
            return Disposables.create {
                
            }
        }
    }
    
    func fetchImageFromDB(imageID:String) -> Observable<(Image)> {
        
        return Observable<(Image)>.create { observer in
            
            // TODO: fetch from Database
            var image1 = Image.init(imageID: "1", title: "tempImage", farm: 1, server: "", secret: "")
            let image = UIImage.init(named: "PlaceHolder")?.data
            image1.mainImage = image
            observer.onNext(image1)
            
            return Disposables.create {
                
            }
        }
    }
    
    func fetchAllImageFromDB() -> Observable<([Image])> {
        
        return Observable<([Image])>.create { observer in
            
            // TODO: fetch from Database
            //Test Data
            var image1 = Image.init(imageID: "1", title: "tempImage", farm: 1, server: "", secret: "")
            let image = UIImage.init(named: "PlaceHolder")
            image1.mainImage = image?.data
            observer.onNext([image1])
            return Disposables.create {
                
            }
        }
    }
}
    
