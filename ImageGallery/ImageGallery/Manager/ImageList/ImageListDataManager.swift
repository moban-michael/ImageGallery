//
//  ImageListDataManager.swift
//  ImageGallery
//
//  Created by Moban Michael on 03/02/2021.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class ImageListDataManager {
    
    private let disposeBag = DisposeBag()
    
    func saveImagesIntoDB(text:String, images:[Image]) -> Observable<(Bool)> {
        
        return Observable<(Bool)>.create { observer in
            
            onMainQueue {
                let realm = try! Realm()
                try! realm.write {
                    for image in images{
                        realm.add(image)
                    }
                }
                observer.onNext(true)
            }
            return Disposables.create {
                
            }
        }
    }
    
    func performDBSearch(text:String) -> Observable<([Image])> {
        
        return Observable<([Image])>.create { observer in
            
            var allImages: [Image] = []
            let predicate = NSPredicate(format: "title BEGINSWITH [c]%@", text)
            let results = try! Realm().objects(Image.self).filter(predicate)
            if results.count <= 0{
                allImages.append(contentsOf: self.getTempData())
            }else{
                allImages.append(contentsOf: results)
            }
            observer.onNext(allImages)
            
            return Disposables.create {
                
            }
        }
    }
    
    func fetchAllImageFromDB() -> Observable<([Image])> {
        
        return Observable<([Image])>.create { observer in
            
            var allImages: [Image] = []
            let results = try! Realm().objects(Image.self)
            if results.count <= 0{
                allImages.append(contentsOf: self.getTempData())
            }else{
                allImages.append(contentsOf: results)
            }
            observer.onNext(allImages)
            
            return Disposables.create {
                
            }
        }
    }
    
    func getTempData() -> [Image]{
        //Temp Data
        let image1 = Image.init(imageID: "1", title: "tempImage", farm: 1, server: "", secret: "")
        let image = UIImage.init(named: "PlaceHolder")
        image1.mainImage = (image?.data)!
        return [image1]
    }
}
    
