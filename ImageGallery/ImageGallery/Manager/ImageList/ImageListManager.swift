//
//  ImageListManager.swift
//  ImageGallery
//
//  Created by Moban Michael on 03/02/2021.
//

import Foundation
import RxCocoa
import RxSwift

class ImageListManager {
    
    private let disposeBag              = DisposeBag()
    private let imageListDataManager    = ImageListDataManager()
    
    func getImageList(searchText:String) -> Observable<([Image])> {
        
        return Observable<([Image])>.create { observer in
            
            ImageServiceManager().searchImage(for: searchText).asObservable().subscribe(onNext: { (searchResult) in
                
                //Store into DB
                self.imageListDataManager.saveImagesIntoDB(images: searchResult.results).asObservable().subscribe { (event) in
                    if event.element != nil{
                        observer.onNext(searchResult.results)
                    }
                }.disposed(by: self.disposeBag)
            }, onError: { (error) in
                print(error)
                observer.onError(Error.failed)
            }, onCompleted: {
                print("Completed")
            }, onDisposed: {
                print("Disposed")
            }).disposed(by: self.disposeBag)
            
            return Disposables.create {
                
            }
        }
    }
    
    func fetchAllImagesFromLocalDB() -> Observable<([Image])> {
        
        return Observable<([Image])>.create { observer in
            
            self.imageListDataManager.fetchAllImageFromDB().asObservable().subscribe { (event) in
                if let images = event.element{
                    observer.onNext(images)
                }
            }.disposed(by: self.disposeBag)
            return Disposables.create {
                
            }
        }
    }
}
