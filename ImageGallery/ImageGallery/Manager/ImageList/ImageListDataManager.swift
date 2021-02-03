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
    
    func saveImagesIntoDB(images:[Image]) -> Observable<(Bool)> {
        
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
            observer.onNext(Image.init(imageID: "", farm: 1, server: "", secret: ""))
            
            return Disposables.create {
                
            }
        }
    }
    
    func fetchAllImageFromDB() -> Observable<([Image])> {
        
        return Observable<([Image])>.create { observer in
            
            // TODO: fetch from Database
            //Test Data
            let image1 = Image.init(imageID: "1", farm: 1, server: "", secret: "")
            let image2 = Image.init(imageID: "2", farm: 1, server: "", secret: "")
            observer.onNext([image1,image2])
            
            return Disposables.create {
                
            }
        }
    }
}
    
