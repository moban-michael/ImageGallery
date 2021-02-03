//
//  ImageListViewModel.swift
//  ImageGallery
//
//  Created by Moban Michael on 02/02/2021.
//

import Foundation
import RxCocoa
import RxSwift

class ImageListViewModel {
    
    var offlineImageList            = PublishRelay<([Image])>()
    var searchOnlineImageList       = PublishRelay<([Image])>()
    var searchOnlineFailed          = PublishRelay<(Bool)>()
    private let disposeBag          = DisposeBag()
    private let imageListManager    = ImageListManager()
    
    
    func getImages(for searchText: String) {
        
        if GeneralUtlis.isNetworkConnectionAvailable() {
            
            ImageListManager().getImageList(searchText: searchText).subscribe { (event) in
                
                if let images = event.element {
                    self.searchOnlineImageList.accept(images)
                }else{
                    self.searchOnlineFailed.accept(true)
                }
            }.disposed(by: self.disposeBag)
        }else{
            fetchAllImageFromLocalDB()
        }
    }
    
    func fetchAllImageFromLocalDB() {
        
        self.imageListManager.fetchAllImagesFromLocalDB().asObservable().subscribe { (event) in
            if let images = event.element{
                self.offlineImageList.accept(images)
            }
        }.disposed(by: self.disposeBag)
    }
}
